@isTest
private class SuccessJsonTest 
{
    static testMethod void testJsonrecord() 
    {
        String jsonbody = '{"FIRST_NAME": "Todd","LAST_NAME": "Kingsford"}';
        SuccessJson.parse(jsonbody);
    }
}