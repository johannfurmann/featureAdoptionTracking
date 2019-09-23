@isTest
public class AdoptionCounterTest  {
    
    @isTest static void increaseAdoptionCounterTest(){
        AdoptionCounter.increaseAdoptionCount('Test Type','Test Action');

        Id userId = UserInfo.getUserId();


        List<Adoption_Counter__c> results=[SELECT Id, Action__c, Count__c, User__c, Feature__c FROM Adoption_Counter__c WHERE User__c =: userId AND CreatedDate = THIS_Week ANd Feature__c ='Test Type' AND Action__c = 'Test Action'];
        Integer size = results.size();

        System.assertEquals(1,size);
        System.assertEquals('Test Action',results[0].Action__c);

        AdoptionCounter.increaseAdoptionCount('Test Type','Test Action');
        List<Adoption_Counter__c> newResults=[SELECT Id, Action__c, Count__c, User__c, Feature__c FROM Adoption_Counter__c WHERE User__c =: userId AND CreatedDate = THIS_Week ANd Feature__c ='Test Type' AND Action__c = 'Test Action'];
        System.assertEquals(1,newResults.size());
        System.assertEquals(2,newResults[0].Count__c);

    }
}
