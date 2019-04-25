@isTest
public class ContactTiggerHelperMethodsTest 
{
    @isTest static void TestUpdateTrigger()
    {

	          
        List<Contact> newContactList = new list<Contact>();
        newContactList.add(new Contact(firstName = 'Stevfdsafden1',lastName='Zfdhao1',email='Zhaosteven76@gmail.com',Employee_Status__C=Orgcontants.PICKLISTVALUE_EmloyeeStatus[0].getLabel(),Start_Date__c=date.today(),gender__C = OrgContants.PICKLISTVALUE_GENDER[0].getLabel()));
        newContactList.add(new Contact(firstName = 'Stefdsafdven2',lastName='Zhfdfdfdao2',email='Zhaosteven76@gmail.com',Employee_Status__C=Orgcontants.PICKLISTVALUE_EmloyeeStatus[0].getLabel(),Start_Date__c=date.today(),gender__C = OrgContants.PICKLISTVALUE_GENDER[0].getLabel()));
        newContactList.add(new Contact(firstName = 'Stefdsafdsven3',lastName='Zhfdsafdsafao3',email='Zhaosteven76@gmail.com',Employee_Status__C=Orgcontants.PICKLISTVALUE_EmloyeeStatus[0].getLabel(),Start_Date__c=date.today(),gender__C = OrgContants.PICKLISTVALUE_GENDER[0].getLabel()));
        list<housing__C> newHousingList = new list<Housing__c>();
        newHousingList.add(new housing__c(Name='The newplace 1',Address__c='11521 Olde Tiverton Cir',
                                          Group_Designation__C=OrgContants.PICKLISTVALUE_HOUSING_GENDER[0].getLabel(),Active__c =true));
        newHousingList.add(new housing__c(Name='The newplace 2',Address__c='11522 Olde Tiverton Cir',
                                          Group_Designation__C=OrgContants.PICKLISTVALUE_HOUSING_GENDER[0].getLabel(),Active__c =true));
        newHousingList.add(new housing__c(Name='The newplace 3',Address__c='11523 Olde Tiverton Cir',
                                          Group_Designation__C=OrgContants.PICKLISTVALUE_HOUSING_GENDER[0].getLabel(),Active__c =true));
        list<Housing_Assignment__c> haList = new list<Housing_Assignment__c>();
        insert newContactList;
        insert newHousingList;

        haList.add(new Housing_Assignment__c(name ='haTest1',housing__c =newHousingList[0].id,contact__c=newContactList[0].id));
        haList.add(new Housing_Assignment__c(name ='haTest1',housing__c =newHousingList[0].id,contact__c=newContactList[1].id));
        haList.add(new Housing_Assignment__c(name ='haTest1',housing__c =newHousingList[0].id,contact__c=newContactList[2].id));
       
   //     insert haList;
        integer contactSize=0;
        integer housingSize=0;
        for(Contact tempC: [Select id,firstName from Contact])
        {
            for(contact tempC2: newContactList)
            {
                if(tempC.FirstName == tempC2.FirstName)
                {
                    contactSize++;
                }
            }
        }
        for(Housing__C tempC: [Select id, Name from Housing__c])
        {
            for(Housing__c tempC2: newHousingList)
            {
                if(tempC.name == tempC2.Name)
                {
                    housingSize++;
                }
            }
        }        

          System.assertEquals(3, housingsize);
          System.assertEquals(3, contactsize);
    }
   
  


}