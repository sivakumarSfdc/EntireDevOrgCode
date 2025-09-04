<aura:application access="GLOBAL" extends="ltng:outApp" >
    
    <!-- if we want to launch the LEX component form CEX VF
 page then include access="GLOBAL" extends="ltng:outApp" here ltng:outApp provides "force:slds" libraries no need to mention
 explicitly.If you dont do this then directlyadd extends="force:slds" for better ui feel  -->
     
    <c:DisplayAccountRecordsAppCompo />
</aura:application>