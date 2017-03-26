/**
 * Share rules for the Email Send Object - - 
 * no changes
 * testing git commit
 * @author Benjamin Myhre
 * @date 04/13/2016
 * @revised 05/25/2016 Ben Myhre
 * Change description - total rewrite to model CommPref_Trigger.cls
 */
global class Email_Send_Trigger extends Framework.Domain{

    String className = Email_Send_Trigger.class.getName();
    
    static final String bgFieldName = SObjectType.et4ae5__SendDefinition__c.fields.Business_Group__c.getName();
    public static CFAMN.RecordSharingService rss = 
        new CFAMN.RecordSharingService(
            SObjectType.et4ae5__SendDefinition__Share.getName(), 
            bgFieldName, 
            'Manual');

    public Email_Send_Trigger(List<et4ae5__SendDefinition__c> sObjectList) {
        super(sObjectList);
    }

    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new Email_Send_Trigger(sObjectList);
        }
        //jgh
    }

    public override void afterInsert(){
        system.debug('***inside after insert');
        Framework.Log.push(className,'afterInsert');
        rss.ShareWithGroup(records);
        Framework.Log.pop();
    }

    public override void beforeUpdate(Map<Id,SObject> oldMap){
        system.debug('***inside before update');
        Framework.Log.push(className,'beforeUpdate');
        rss.UnshareAndshareWithGroup(oldMap, records, true);
        Framework.Log.pop();
    }

}