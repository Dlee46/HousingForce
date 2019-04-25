/**************************************************************************
 * 	Purpose: A class to hold all of the methods for the ServiceAppointmentEnail
 * 	Author:	 Steven Zhao
 * 	Created Date:	 4/23/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/23/19
 * 	Description:	
 *************************************************************************/ 
public class ServiceAppointmentEmail 
{
/**************************************************************************
 * 	Purpose: return a map of contactid and serivce.
 * 	Author:	 Steven Zhao
 * 	Created Date:	 4/23/19
 * 	Last Modifyied Author: Steven Zhao
 *  Last Modifyied Date: 4/23/19
 * 	Description:	
 *************************************************************************/ 
	public static Map<id,String> returnServiceAppointment(list<ID> newlist)
    {
       Map<id,String> ServiceList = new Map<id,string>();
       For(HOUSING__C tempH: [SELECT  (SELECT 	Service_Interval__c	,DayOfWeek__c,time__C FROM Service_Appointments__R 
                                       WHERE Type_of_Service__c = :OrgContants.PICKLISTVALUE_SERVICE_APPOINTMENT_TYPEOFSERVICE[0].getLabel()
                                       AND 	Service_Interval__c !=0),
                              (SELECT CONTACT__C FROM HOUSING_ASSIGNMENTS__R WHERE CONTACT__C IN :NEWLIST)
                              FROM HOUSING__C 
                              WHERE ID IN (SELECT  HOUSING__C FROM HOUSING_ASSIGNMENT__C WHERE CONTACT__C IN :NEWLIST ) ])
       {
           For(Service_Appointment__c tempSAC: tempH.Service_Appointments__r)
           {
               FOR(Housing_Assignment__C tempHA : tempH.housing_assignments__r)
               {
                   if(ServiceList.get(tempHA.contact__C)==null)
                   		ServiceList.put(tempHA.contact__C,(' day : '+GeneralHelpers.returnDayofWeek(integer.valueof(tempSAC.DayOfWeek__c))+' every '+GeneralHelpers.returnWeekANDdays(integer.valueOF(tempSAC.Service_Interval__c))+ ' Time: ' + tempSAC.time__C));
               }
             	
           }
       }
        return ServiceList;
    }

    

}