@isTest
private class ErrorResponseTest 
{
    static testMethod void testrecord() 
    {
        String jsonbody = '[{"msg":"Test","interest":"Other","whendt":"2012-02-15T18:03:32-08:00"}]';
        ErrorResponse.parse(jsonbody);
    }
}