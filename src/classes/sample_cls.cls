public class sample_cls {
    public static void main() {
        try {


//https://salesforce.stackexchange.com/questions/79497/can-conga-use-one-template-multiple-times-in-one-solution

            String serverUrl = Url.getSalesforceBaseUrl().toExternalForm()+'/services/Soap/u/13.0/'+UserInfo.getOrganizationId();
            String endpoint = 'https://composer.congamerge.com?SessionId='+UserInfo.getSessionId()+'&ServerUrl='+serverUrl;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            //req.setHeader('Content-Type', 'application/json');
            //req.setBody('{	"org_id": "00D0o000000SB4t"}');
            //req.setBody('{	"org_id": "' + orgId + '"}');

            Http http = new Http();
            HTTPresponse res = http.send(req);
            string response = res.getBody();
            System.debug('response-->' + response);
        } catch (exception e) {
            System.debug('get exception on line number-->' + e.getLineNumber() + '	error is--> ' + e.getMessage());
        }
    }
    }