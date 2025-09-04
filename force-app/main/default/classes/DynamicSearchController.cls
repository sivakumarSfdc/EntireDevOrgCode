public with sharing class DynamicSearchController {

    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> searchRecords(String objectName, String filterFields, 
    String displayFields, Map<String, String> inputValues) {
        List<Map<String, Object>> results = new List<Map<String, Object>>();
        try {
            String objectApiName = getObjectApiName(objectName);
            if (objectApiName != null) {
                Map<String, String> mpOfDisplayFields = getFieldApiNames(objectApiName, displayFields.split(','));
                Map<String, String> mpOfFilterFields = getFieldApiNames(objectApiName, filterFields.split(','));
                System.debug('mpOfDisplayFields : ' + mpOfDisplayFields);
                System.debug('mpOfFilterFields : ' + mpOfFilterFields);
                if (!mpOfDisplayFields.isEmpty() && !mpOfFilterFields.isEmpty()) {
                    String query = 'SELECT ' + String.join(mpOfDisplayFields.values(), ', ') + ' FROM ' + objectApiName + ' WHERE ';
                    List<String> filters = new List<String>();
                    for (String label : mpOfFilterFields.keySet()) {
                        String fieldName = mpOfFilterFields.get(label);
                        if (inputValues.containsKey(label)) {
                            filters.add(fieldName + ' LIKE \'%' + inputValues.get(label) + '%\'');
                        }
                    }
                    if (!filters.isEmpty()) {
                        query += String.join(filters, ' AND ');
                    } else {
                        query = query.replace(' WHERE ', ''); // Remove WHERE clause if no filters
                    }
                    System.debug('Query :' + query);
                    
                    // Execute the query and return results
                    List<SObject> sObjectResults = Database.query(query);
                    for (SObject record : sObjectResults) {
                        Map<String, Object> resultMap = new Map<String, Object>();
                        for (String field : mpOfDisplayFields.values()) {
                            resultMap.put(field, record.get(field));
                        }
                        results.add(resultMap);
                    }
                }
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error in searchRecords: ' + e.getMessage());
        }
        return results;
    }

    @AuraEnabled(cacheable=true)
    public static String getObjectApiName(String objectLabel) {
        try {
            EntityDefinition entityDef = [
                SELECT QualifiedApiName 
                FROM EntityDefinition 
                WHERE MasterLabel = :objectLabel
                LIMIT 1
            ];

            if (entityDef != null) {
                return entityDef.QualifiedApiName;
            } else {
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error in getObjectApiName: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, String> getFieldApiNames(String objectApiName, List<String> fieldLabels) {
        Map<String, String> fieldLabelToApiNameMap = new Map<String, String>();
        try {
            if (objectApiName != null) {
                List<FieldDefinition> fieldDefs = [
                    SELECT QualifiedApiName, Label 
                    FROM FieldDefinition 
                    WHERE EntityDefinition.QualifiedApiName = :objectApiName
                    AND Label IN :fieldLabels
                ];

                if (fieldDefs.isEmpty()) {
                    throw new AuraHandledException('No fields found for the given labels.');
                }

                for (FieldDefinition fieldDef : fieldDefs) {
                    fieldLabelToApiNameMap.put(fieldDef.Label, fieldDef.QualifiedApiName);
                }
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error in getFieldApiNames: ' + e.getMessage());
        }

        return fieldLabelToApiNameMap;
    }
}