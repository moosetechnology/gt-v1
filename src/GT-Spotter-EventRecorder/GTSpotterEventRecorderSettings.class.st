Class {
	#name : #GTSpotterEventRecorderSettings,
	#superclass : #Object,
	#instVars : [
		'url',
		'sendUsageData',
		'sendSearchQuery',
		'computerUUID'
	],
	#classInstVars : [
		'url',
		'uniqueInstance'
	],
	#category : #'GT-Spotter-EventRecorder'
}

{ #category : #'load and saving' }
GTSpotterEventRecorderSettings class >> deletePreferences [
	"self deletePreferences"
	[ self preferences ensureDelete ]
	on: Error do: [ "ignore" ]
]

{ #category : #'reflective operations' }
GTSpotterEventRecorderSettings class >> doesNotUnderstand: aMessage [ 
	"delegate all settings to the unique instance"
	^ self uniqueInstance perform: aMessage selector withEnoughArguments: aMessage arguments
]

{ #category : #'class initialization' }
GTSpotterEventRecorderSettings class >> initialize [
	super initialize.
	Smalltalk addToStartUpList: self.
	self loadPreferences.
]

{ #category : #'load and saving' }
GTSpotterEventRecorderSettings class >> loadPreferences [
	"self loadPreferences"
	| newInstance |
	self preferences exists ifFalse: [ ^ self savePreferences ].
	[ 
		newInstance := FLMaterializer materializationFromFileNamed: self preferences.
		newInstance computerUUID = self uniqueInstance computerUUID
			ifFalse: [ uniqueInstance := newInstance ]
	] on: Error do: [ self savePreferences ]
]

{ #category : #origins }
GTSpotterEventRecorderSettings class >> preferences [
	^ FileLocator preferences / 'org.pharo.gt.spotter.event.recorder.fuel' 
]

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> reset [
	"self reset"
	uniqueInstance := nil
]

{ #category : #'load and saving' }
GTSpotterEventRecorderSettings class >> savePreferences [
	"self savePreferences"
	self deletePreferences.
	[ FLSerializer serialize: self uniqueInstance toFileNamed: self preferences ]
		on: Error do: [ "ignore" ]
]

{ #category : #settings }
GTSpotterEventRecorderSettings class >> settingsOnSendSearchQuery: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #sendSearchQuery)
		parent: #gt;
		target: self;
		description: 'Spotter: Send search query and selected search results' translated;
		label: 'Spotter: Send search query and selected search results'

]

{ #category : #settings }
GTSpotterEventRecorderSettings class >> settingsOnSendUsageData: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #sendUsageData)
		parent: #gt;
		target: self;
		description: 'Send basic anonymous usage data.' translated;
		label: 'Send basic anonymous usage data'

]

{ #category : #settings }
GTSpotterEventRecorderSettings class >> settingsOnUrl: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #stringUrl)
		parent: #gt;
		target: self;
		description: 'The url for the Spotter Event Recorder server.' translated;
		label: 'Spotter Event Recorder URL address'

]

{ #category : #'system startup' }
GTSpotterEventRecorderSettings class >> startUp: resuming [
	self loadPreferences
]

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> computerUUID [
	^ computerUUID
]

{ #category : #initialization }
GTSpotterEventRecorderSettings >> initialize [
	super initialize.
	computerUUID := UUID new.
	
]

{ #category : #actions }
GTSpotterEventRecorderSettings >> save [
	self class savePreferences
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> sendSearchQuery [
	^ sendSearchQuery ifNil: [ sendSearchQuery := false ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> sendSearchQuery: aBoolean [
	sendSearchQuery := aBoolean.
	self save.
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> sendUsageData [
	^ sendUsageData ifNil: [ sendUsageData := true ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> sendUsageData: aBoolean [
	sendUsageData := aBoolean.
	self save.
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> stringUrl [
	^ self url asString
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> stringUrl: aUrlString [
	^ self url: aUrlString
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> url [
	^ url ifNil: [ url := 'http://gc.dcc.uchile.cl.:8080/gt/events' asZnUrl ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> url: aZnUrl [
	url := aZnUrl ifNotNil: [ aZnUrl asZnUrl ].
	self save.
]
