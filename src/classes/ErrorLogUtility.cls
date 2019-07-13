/**
@author:            Chris Baldock
@company:           SaaSFocus
@description:       Utility class to help log consistent messages into the Error_Log__c object
@inputs:            logLevel         - Debug, Error, Info, Warning
                    sourceClass      - Originating apex class
                    sourceFunction   - Method in class above that initiated the log
                    ex               - The standard exception object for errors
                    message          - The user friendly message associated with the log record
                    referenceId      - The salesforce record or job ID related to the log
                    referenceInfo    - Additional context about the reference ID (e.g. Apex Batch, Web Callout, Contact etc,,,)
                    payLoad          - Optional payload. E.g. could be used to log the Request and Response of a web callout
                    logCode          - Optional logCode. Used for reporting purposes
 
@history
<Date>        <Authors Name>        <Brief Description of Change>
28-09-17      Priyank                  created
*/
public class ErrorLogUtility {
 
    public static final String LOGLEVEL_ERROR = 'Error';
    public static final String LOGLEVEL_DEBUG = 'Debug';
    public static final String LOGLEVEL_INFO = 'Info';
    public static final String LOGLEVEL_WARN = 'Warning';
 
    // TODO: alter the below to instead use a custom metadata type
    private static Boolean errorLoggingIsEnabled = true;
    private static Boolean debugLoggingIsEnabled = true;
    private static Boolean infoLoggingIsEnabled = true;
    private static Boolean warnLoggingIsEnabled = true;
 
    private static List<ErrorLogWrapper> errorLogContainer = new List<ErrorLogWrapper>();
 
   /**
   @author:          Chris Baldock
   @company:         SaaSFocus
   @description:      Method to log a single ERROR record.
                   Used to log exceptions that need support team visibility (e.g. a controller class failed to update a record)
   @inputs:          See class "Inputs" above
   @history
   <Date>        <Authors Name>        <Brief Description of Change>
   30-May-17   Chris Baldock      created
   */
    public static void logError(
            String sourceClass,
            String sourceFunction,
            Database.Error ex,
            String message,
            String referenceID,
            String referenceInfo,
            String payLoad,
            String logCode) {
 
        if(errorLoggingIsEnabled) {
            insertLog(LOGLEVEL_ERROR, sourceClass, sourceFunction, ex, message, referenceID, referenceInfo, payLoad, logCode);
        }
    }
 
   /**
   @author:          Chris Baldock
   @company:         SaaSFocus
   @description:     Method to log a single DEBUG record.
                     Used to log a statement that will assist with issue resolution (e.g. log the request and response from a web service callout)
   @inputs:          See class "Inputs" above
   @history
   <Date>        <Authors Name>        <Brief Description of Change>
   30-May-17   Chris Baldock      created
   */
    public static void logDebug(
            String     sourceClass,
            String     sourceFunction,
            String     message,
            String     referenceID,
            String     referenceInfo,
            String     payLoad,
            String     logCode) {
 
        if(debugLoggingIsEnabled) {
            insertLog(LOGLEVEL_DEBUG, sourceClass, sourceFunction, null, message, referenceID, referenceInfo, payLoad, logCode);
        }
    }
 
 
 
   /**
   @author:          Chris Baldock
   @company:         SaaSFocus
   @description:     Method to log a single INFO record.
                     Used to log information about a process (e.g. when a batch job finished, how many records were processed, how many batches were used, what time did the job start and finish)
   @inputs:          See class "Inputs" above
   @history
   <Date>        <Authors Name>        <Brief Description of Change>
   30-May-17   Chris Baldock      created
   */
    public static void logInfo(    
            String     sourceClass,
            String     sourceFunction,
            String     message,
            String     referenceID,
            String     referenceInfo,
            String     payLoad,
            String     logCode) {
 
        if(infoLoggingIsEnabled) {
            insertLog(LOGLEVEL_INFO, sourceClass, sourceFunction, null, message, referenceID, referenceInfo, payLoad, logCode);
        }
    }
 
   /**
   @author:          Chris Baldock
   @company:         SaaSFocus
   @description:     Method to log a single WARNING record.
                     Used to notify the support team that one or more application limits are in danger of being reached (e.g. an Account trigger results in 80 SOQL queries)
   @inputs:          See class "Inputs" above
   @history
   <Date>        <Authors Name>        <Brief Description of Change>
   30-May-17   Chris Baldock      created
   */
    public static void logWarn(    
            String     sourceClass,
            String     sourceFunction,
            String     message,
            String     referenceID,
            String     referenceInfo,
            String     payLoad,
            String     logCode) {
 
        if(warnLoggingIsEnabled) {
            insertLog(LOGLEVEL_WARN, sourceClass, sourceFunction, null, message, referenceID, referenceInfo, payLoad, logCode);
        }
    }
 
   /**
   @author:          Chris Baldock
   @company:         SaaSFocus
   @description:     Method to add a single record to the errorLogContainer. Must call commitLog() to commit all contents
   @inputs:          See class "Inputs" above
   @history
   <Date>        <Authors Name>        <Brief Description of Change>
   30-May-17   Chris Baldock      created
   */
    private static void insertLog( 
            String logLevel,
            String sourceClass,
            String sourceFunction,
            Database.Error ex,
            String message,
            String referenceId,
            String referenceInfo,
            String payLoad,
            String logCode) {
 
 
        try {
            ErrorLogWrapper errorLog = new ErrorLogWrapper();
 
            if(logLevel!=null) errorLog.logLevel = logLevel;
            if(sourceClass!=null) errorLog.sourceClass = sourceClass;
            if(sourceFunction!=null) errorLog.sourceFunction = sourceFunction;
            if(message!=null) errorLog.message = message;
            if(referenceId!=null) errorLog.referenceId = referenceID;
            if(referenceInfo!=null) errorLog.referenceInfo = referenceInfo;
            if(payLoad!=null) errorLog.payLoad = payLoad;
            if(logCode!=null) errorLog.logCode = logCode;
           // if(ex!=null) errorLog.stackTrace = ex.getStackTraceString();
 
            errorLogContainer.add(errorLog);
        }
        catch(Exception e) {
            System.debug('Failed to add errorLog to errorLogContainer'
                    + ' Error = ' + e.getMessage()
                    + ' logLevel='+logLevel
                    + ' sourceClass='+sourceClass
                    + ' sourceFunction='+sourceFunction
                    + ' ex='+ex
                    + ' message='+message
                    + ' referenceID='+referenceID
                    + ' referenceInfo='+referenceInfo
                    + ' payLoad='+payLoad
                    + ' logCode='+logCode);
        }
    }
 
   /**
   @author:          Chris Baldock
   @company:         SaaSFocus
   @description:     Method will attempt to insert errorLogContainer into the Error_Log__c sObject
   @inputs:          See class "Inputs" above
   @history
   <Date>        <Authors Name>        <Brief Description of Change>
   30-May-17   Chris Baldock      created
   */
    public static void commitLog() {
        if (!errorLogContainer.isEmpty()) {
            List<Error_Log__c> errorLogsForInsert = new List<Error_Log__c>();
            for (ErrorLogWrapper log : errorLogContainer) {
                Error_Log__c errorLog = new Error_Log__c();
 
                errorLog.Log_Level__c = log.logLevel;
                errorLog.Source__c = log.sourceClass;
                errorLog.Source_Function__c = log.sourceFunction;
                errorLog.Message__c = log.message;
                errorLog.Reference_ID__c = log.referenceId;
                errorLog.Reference_Info__c = log.referenceInfo;
                errorLog.Payload__c = log.payLoad;
                errorLog.Log_Code__c = log.logCode;
                errorLog.Stack_Trace__c = log.stackTrace;
 
                errorLogsForInsert.add(errorLog);
            }
            try{
                insert errorLogsForInsert;
            }
            catch(Exception e){
                System.debug('Failed to insert contents of errorLogContainer to Error_Log__c'
                + ' Error Message = ' + e.getMessage());
               // + ' Error Stack Trace = ' + e.getStackTraceString());
            }
        }
    }
 
    /**
    @author:          Chris Baldock
    @company:         SaaSFocus
    @description:     Method will attempt to insert errorLogContainer into the Error_Log__c sObject
    @inputs:          See class "Inputs" above
    @history
    <Date>        <Authors Name>        <Brief Description of Change>
    30-May-17   Chris Baldock      created
    */
    private class ErrorLogWrapper {
        public String logLevel {get; set;}
        public String sourceClass {get; set;}
        public String sourceFunction {get; set;}
        public String message {get; set;}
        public String referenceId {get; set;}
        public String referenceInfo {get; set;}
        public String payLoad {get; set;}
        public String logCode {get; set;}
        public String stackTrace {get; set;}
    }
 
}