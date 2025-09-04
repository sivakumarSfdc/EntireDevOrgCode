public class AccountTaskCreationHandler {
    
    public static void createTask(List<Account> lsOfAccs) {
        Map<Id, Account> mpOfValidAccs = new Map<Id, Account>();
        for (Account a : lsOfAccs) {
            if (a.AccountSource == 'Email' && String.isNotBlank(a.Email__c)) {
                mpOfValidAccs.put(a.Id, a);
            }
        }

        if (mpOfValidAccs.isEmpty()) return;

        // Get current user and their profile
        User currentUser = [
            SELECT Id, Name, Profile.Name 
            FROM User 
            WHERE Id = :UserInfo.getUserId()
            LIMIT 1
        ];

        // Always create "Patient Got On-Board" task
        insertTasks(UserInfo.getUserId(), mpOfValidAccs, false);

        // If user is Integration User (Bank: Account Manager), do email + task
        if (currentUser.Profile.Name == 'Bank: Account Manager') {
            insertTasks(UserInfo.getUserId(), mpOfValidAccs, true);
            sendEmails(mpOfValidAccs);
        }
    }

    private static void insertTasks(Id ownerId, Map<Id, Account> accMap, Boolean isEmailTask) {
        List<Task> taskList = new List<Task>();

        for (Account acc : accMap.values()) {
            Task t = new Task();
            // Optional: Use System Admin ID or Integration User ID here if needed
            t.OwnerId = ownerId;
            t.WhatId = acc.Id;
            t.Status = 'Not Started';
            t.Subject = 'Email';
            t.Description = isEmailTask ? 'Email Sent' : 'Patient Got On-Board';
            t.Priority = 'Normal';
            t.CurrencyIsoCode = acc.CurrencyIsoCode;
            taskList.add(t);
        }

        try {
            if (!taskList.isEmpty()) {
                insert taskList;
            }
        } catch (DmlException e) {
            System.debug('⚠️ Task creation failed: ' + e.getMessage());
            // Optional: store errors in custom log object or handle fallback
        }
    }

    private static void sendEmails(Map<Id, Account> accMap) {
        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();

        OrgWideEmailAddress owd;
        try {
            List<OrgWideEmailAddress> owds = [
                SELECT Id FROM OrgWideEmailAddress 
                WHERE Address = 'sivakumarthota13@gmail.com' 
                LIMIT 1
            ];
            if (!owds.isEmpty()) {
                owd = owds[0];
            }
        } catch (Exception e) {
            System.debug('⚠️ No Org-Wide Email Address found or query failed');
        }

        for (Account acc : accMap.values()) {
            if (String.isNotBlank(acc.Email__c)) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { acc.Email__c });

                if (owd != null) {
                    mail.setOrgWideEmailAddressId(owd.Id);
                } else {
                    mail.setReplyTo(UserInfo.getUserEmail());
                    mail.setSenderDisplayName('Your Company');
                }

                mail.setSubject('Welcome to Our Services');

                String body = 'Dear ' + (String.isNotBlank(acc.Name) ? acc.Name : 'Customer') + ',\n\n'
                            + 'Welcome! Your account has been successfully created and onboarded.\n\n'
                            + 'Feel free to reach out if you have any questions.\n\n'
                            + 'Thanks,\n'
                            + 'Your Company Team';

                mail.setPlainTextBody(body);
                emailsToSend.add(mail);
            }
        }

        if (!emailsToSend.isEmpty()) {
            Messaging.sendEmail(emailsToSend);
        }
    }
}