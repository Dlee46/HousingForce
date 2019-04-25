public class OutBoundEmail 
{
/**************************************************************************
 * 	Purpose: to send an email with the same subject and body to many different people
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	
 *************************************************************************/ 
    public static list<Messaging.SingleEmailMessage> Create_Email(list<String> newEmailList, String subject, List<String> body )
    {
        List<Messaging.SingleEmailMessage> listOfEmail= new list<Messaging.SingleEmailMessage>();
        if(newEmailList != null && newEmailList.size() > 0)
        {
            
            for(Integer i =0; i < newEmailList.size(); i++)
            {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{newEmailList[i]});
                email.setSubject(subject);
                email.setPlainTextBody(body[i]);
                listOfEmail.add(email);
            }
            
        }
	return listOfEmail;
    }
/**************************************************************************
 * 	Purpose: to send an email with the same subject and body to many different people
 * 	Author:	 Steven Zhao
 * 	Created Date:	4/19/19
 * 	Last Modifyied Author:Steven Zhao
 *  Last Modifyied Date:4/19/19
 * 	Description:	this accepts only string for the bodytext
 *************************************************************************/ 
    public static list<Messaging.SingleEmailMessage> Create_Email(list<String> newEmailList, String subject, String body )
    {
        List<Messaging.SingleEmailMessage> listOfEmail= new list<Messaging.SingleEmailMessage>();
        if(newEmailList != null && newEmailList.size() > 0)
        {
            
            for(Integer i =0; i < newEmailList.size(); i++)
            {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{newEmailList[i]});
                email.setSubject(subject);
                email.setPlainTextBody(body);
                listOfEmail.add(email);
            }
            
        }
	return listOfEmail;
    }
}