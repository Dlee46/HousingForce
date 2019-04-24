public class ServiceController {
    // Property to retrieve Service_Appointment__c
    public Service_Appointment__c services{
        get{
            if(services == null){
                this.services = new Service_Appointment__c();
            }
            return services;
        }
        set;
    }
    // Property for a new List of Service Appointments
    public List<Service_Appointment__c> newServList {
        get{
            if(newServList == null){
                newServList = new List<Service_Appointment__c>();
            }
            return newServList;
        }
        set;
    }
    // Property to get a list of most recent services
    public List<Service_Appointment__c> serviceList{
        get{
            if(serviceList == null){
                Integer mnth = System.Today().Month();
                Integer yr = System.Today().Year();
                serviceList = new List<Service_Appointment__c>();
                for(Service_Appointment__c sa : [SELECT Id, DayOfWeek__c, Cleaning_Reason__c, Maintenance_Reason__c, Service_Interval__c, Type_Of_Service__c, Company_Name__c, Date__c, Housing__c, Name, Time__c
                                                 FROM Service_Appointment__c 
                                                 WHERE CALENDAR_MONTH(Date__c) = :mnth AND CALENDAR_YEAR(Date__c) = :yr 
                                                 ORDER BY Date__c 
                                                 LIMIT 15]){                    
                                                     serviceList.add(sa);
                                                 }                
            }
            return serviceList;
        }
        set;
    }
    // Method to save
    public PageReference save(){
		this.newServList.add(this.services);
        return null;
    }
    // Method to cancel
    public PageReference cancel(){
        return null;
    }
    // Property to for bringing in the most recent service
    public List<Service_Appointment__c> upcomingService{
        get{
            if(upcomingService == null){
                Integer mnth = System.Today().Month();
                Integer yr = System.Today().Year();
                upcomingService = new List<Service_Appointment__c>();
                for(Service_Appointment__c us : [SELECT Id, Cleaning_Reason__c, Maintenance_Reason__c, Service_Interval__c, Type_Of_Service__c, Company_Name__c, Date__c, Housing__c, Name, Time__c 
                                                 FROM Service_Appointment__c 
                                                 WHERE CALENDAR_MONTH(Date__c) = :mnth AND CALENDAR_YEAR(Date__c) = :yr 
                                                 ORDER BY Date__c 
                                                 LIMIT 1]){                    
                                                     upcomingService.add(us);
                                                 }                
            }
            return upcomingService;
        }
        set;
    }
    // Property to get picklist values for Type_Of_Service__c
    public List<SelectOption> serviceType{
        get{
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult fieldResult = Service_Appointment__c.Type_Of_Service__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            for( Schema.PicklistEntry f : ple)
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            return options;
        }
    }
    // Property to get picklist values for Cleaning_Reason__c
    public List<SelectOption> cleaningOption{
        get{
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult fieldResult = Service_Appointment__c.Cleaning_Reason__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            for( Schema.PicklistEntry f : ple)
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            return options;
        }
    }
    // Property to get picklist values for Maintenance_Reason__c
    public List<SelectOption> maintenanceOption{
        get{
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult fieldResult = Service_Appointment__c.Maintenance_Reason__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
            for( Schema.PicklistEntry f : ple)
                options.add(new SelectOption(f.getLabel(), f.getValue()));
            return options;
        }
    }
}