public class HomeExtension {

    public Task tasks {
        get{
            if(tasks == null){
                this.tasks = new Task();
            }
            return tasks;
        }
        set;
    }
    
    public List<Task> tList {
        get{
            if(tList == null){
                tList = new List<Task>();
                for(Task t : [SELECT Priority, ActivityDate, Status, Subject, Type, WhoId, Description 
                              FROM Task 
                              WHERE ActivityDate = THIS_MONTH]){
                                  tList.add(t);
                              }
            }
            return tList;
        }
        set;
    }
    
    
}