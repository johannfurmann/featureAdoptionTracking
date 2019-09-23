public class AdoptionCounter  {

    //Method for Processbuilder
    @InvocableMethod(label='Increase Adoption Counter' description='Provide it a featuer action combination to incease adoption count')
    public static void increaseAdoptionCountInvocable(List<FeatureActionWrapper > featureActionList){
        //Yes dirty, only works for Trigger Size 1
        for(FeatureActionWrapper fAw:  featureActionList){
            AdoptionCounter.performAdoptionOperation(fAw.feature, fAw.action);
            break;
        }
    }
    
    //Lightning Component Method
    @AuraEnabled
    public static void increaseAdoptionCount(String feature, String actionType){
        AdoptionCounter.performAdoptionOperation(feature, actionType);
    }

    public static void performAdoptionOperation(String feature, String actionType){
        //Get Current User
        Id userId = UserInfo.getUserId();

        //Check if entry already exists
        Adoption_Counter__c newAdoptionCounter = new Adoption_Counter__c();
        //Test
        String query = 'SELECT Id, Action__c, Count__c, User__c, Feature__c FROM Adoption_Counter__c WHERE User__c =: userId AND CreatedDate = THIS_Week ANd Feature__c =: feature AND Action__c =: actionType';
        query += ' LIMIT 1 ';

        List<Adoption_Counter__c> adoptionEntryCurrentWeek = Database.query(query);

        //Entry already exists -> Increase by one 
        if(!adoptionEntryCurrentWeek.isEmpty()) {
            newAdoptionCounter = adoptionEntryCurrentWeek[0];
            newAdoptionCounter.Count__c +=1;
        
        }

        //Entry does not exist -> Create One

        if(adoptionEntryCurrentWeek.isEmpty()) {
            newAdoptionCounter.User__c = userId;
            newAdoptionCounter.Action__c = actionType;
            newAdoptionCounter.Feature__c = feature;
            newAdoptionCounter.Count__c = 1;
        }

        //Upsert Entry
        upsert newAdoptionCounter;
    
    }
    
    public class FeatureActionWrapper {
        @InvocableVariable(required=true)
        public String feature;
        
        @InvocableVariable(required=true)
        public String action;
              
    }    
}
