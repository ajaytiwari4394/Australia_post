<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Stage_Change</fullName>
        <field>Stage_Change_Date__c</field>
        <formula>today()</formula>
        <name>Stage Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Duplicate_Key</fullName>
        <field>Duplicate_Key__c</field>
        <formula>Name+Account.PersonContact.Email</formula>
        <name>Update Duplicate Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>StageChangeDate</fullName>
        <actions>
            <name>Stage_Change</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>when stage will change update that date</description>
        <formula>ISCHANGED(StageName)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Duplicate Key</fullName>
        <actions>
            <name>Update_Duplicate_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.PersonEmail</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Call Opportunity</fullName>
        <actions>
            <name>zaapit__Call_oppts</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Call Opportunity - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Email Opportunity</fullName>
        <actions>
            <name>zaapit__Email_oppts</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Email Opportunity - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Letter Opportunity</fullName>
        <actions>
            <name>zaapit__Send_Letter_oppts</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Letter Opportunity - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Quote Opportunity</fullName>
        <actions>
            <name>zaapit__Send_Quote_oppts</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Quote Opportunity - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>zaapit__Call_oppts</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Call</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Email_oppts</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Email</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Send_Letter_oppts</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Letter</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Send_Quote_oppts</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Quote</subject>
    </tasks>
</Workflow>
