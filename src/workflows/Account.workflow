<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_City</fullName>
        <field>PersonMailingCity</field>
        <formula>BillingCity</formula>
        <name>Copy City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Country</fullName>
        <field>PersonMailingCountry</field>
        <formula>BillingCountry</formula>
        <name>Copy Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_State</fullName>
        <field>PersonMailingState</field>
        <formula>BillingState</formula>
        <name>Copy State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Street</fullName>
        <field>PersonMailingStreet</field>
        <formula>BillingStreet</formula>
        <name>Copy Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Zip</fullName>
        <field>PersonMailingPostalCode</field>
        <formula>BillingPostalCode</formula>
        <name>Copy Zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Mirror Billing Address</fullName>
        <actions>
            <name>Copy_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Zip</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Person Account</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Call  - Account %28Exmaple by ZaapIT%29</fullName>
        <active>false</active>
        <description>Call Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Call %28Exmaple by ZaapIT%29</fullName>
        <active>false</active>
        <description>Call Account Example by ZaapIT (don&apos;t activated - an example)</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Email - Account %28Exmaple by ZaapIT%29</fullName>
        <actions>
            <name>zaapit__Email</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Email Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Letter  - Account %28Exmaple by ZaapIT%29</fullName>
        <actions>
            <name>zaapit__SendLetterAccount</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Letter Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>zaapit__Send Quote - Account %28Exmaple by ZaapIT%29</fullName>
        <actions>
            <name>zaapit__SendQuoteAccount</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Send Quote Account - by ZaapIT</description>
        <formula>false</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>zaapit__Call</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Call</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__Email</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Email</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__SendLetterAccount</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Letter</subject>
    </tasks>
    <tasks>
        <fullName>zaapit__SendQuoteAccount</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Send Quote</subject>
    </tasks>
</Workflow>
