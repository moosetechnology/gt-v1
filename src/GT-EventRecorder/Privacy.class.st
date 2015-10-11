"
I represent basic privacy question about collecting user activities and other data that helps to improve Pharo and related tools.

Responsibility: 
I keep information about sending diagnostic and usage data. 

Collaborators:
I only keep the privacy information. All services that collects diagnostic and usage data should do it only if #sendDiagnosticsAndUsageData is true. 

If you want to add more specific settings related to privacy, you can put it to the privacy group.

Public API and Key Messages

- sendDiagnosticsAndUsageData   

"
Class {
	#name : #Privacy,
	#superclass : #Object,
	#classInstVars : [
		'sendDiagnosticsAndUsageData'
	],
	#category : #'GT-EventRecorder-Privacy'
}

{ #category : #cleanup }
Privacy class >> cleanUp [
	"Clean settings."
	sendDiagnosticsAndUsageData := nil.
]

{ #category : #settings }
Privacy class >> privacySettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #privacy)
		label: 'Privacy';
		noOrdering;
		description: 'All settings concerned with privacy'
]

{ #category : #accessing }
Privacy class >> sendDiagnosticsAndUsageData [
	^ sendDiagnosticsAndUsageData ifNil: [ sendDiagnosticsAndUsageData := true ]
]

{ #category : #accessing }
Privacy class >> sendDiagnosticsAndUsageData: aBoolean [
	sendDiagnosticsAndUsageData := aBoolean
]

{ #category : #settings }
Privacy class >> sendDiagnosticsAndUsageUsageDataSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #sendDiagnosticsAndUsageData)
		label: 'Send diagnostics and usage data';
		noOrdering;
		description: 'Help Pharo community improve its products and services by automatically sending diagnostic and usage data.';
		parent: #privacy
]
