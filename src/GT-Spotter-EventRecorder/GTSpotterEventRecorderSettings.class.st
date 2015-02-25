Class {
	#name : #GTSpotterEventRecorderSettings,
	#superclass : #Object,
	#instVars : [
		'url',
		'includeDeveloperName',
		'rememberSettings',
		'sendUsageData',
		'sendSearchQuery'
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
	self preferences ensureDelete
]

{ #category : #'reflective operations' }
GTSpotterEventRecorderSettings class >> doesNotUnderstand: aMessage [ 
	"delegate all settings to the unique instance"
	^ self uniqueInstance perform: aMessage selector withEnoughArguments: aMessage arguments
]

{ #category : #'class initialization' }
GTSpotterEventRecorderSettings class >> initialize [
	super initialize.
	self loadPreferences.
]

{ #category : #'load and saving' }
GTSpotterEventRecorderSettings class >> loadPreferences [
	"self loadPreferences"
	self preferences exists ifFalse: [ ^ self ].
	self preferences readStreamDo: [ :aStream |
		[ uniqueInstance := STON fromStream: aStream ] on: STONReaderError do: [ "ignore" ] ]
]

{ #category : #origins }
GTSpotterEventRecorderSettings class >> preferences [
	^ FileLocator preferences / 'org.pharo.gt.spotter.event.recorder.txt' 
]

{ #category : #'load and saving' }
GTSpotterEventRecorderSettings class >> savePreferences [
	"self savePreferences"
	self preferences writeStreamDo: [ :aStream |
		STON put: self uniqueInstance onStreamPretty: aStream ]
]

{ #category : #settings }
GTSpotterEventRecorderSettings class >> settingsOnIncludeDeveloperName: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #includeDeveloperName)
		parent: #gt;
		target: self;
		description: 'Include developer name.' translated;
		label: 'Include developer name'

]

{ #category : #settings }
GTSpotterEventRecorderSettings class >> settingsOnRememberSettings: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #rememberSettings)
		parent: #gt;
		target: self;
		description: 'Remember settings between images.' translated;
		label: 'Remember settings between images'

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

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> includeDeveloperName [
	^ includeDeveloperName ifNil: [ includeDeveloperName := false ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> includeDeveloperName: aBoolean [
	includeDeveloperName := aBoolean.
	self save.
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> rememberSettings [
	^ rememberSettings ifNil: [ rememberSettings := true ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> rememberSettings: aBoolean [
	rememberSettings := aBoolean.
	self save.
]

{ #category : #actions }
GTSpotterEventRecorderSettings >> save [
	self rememberSettings 
		ifTrue: [ self class savePreferences ]
		ifFalse: [ self class deletePreferences ]
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
	^ url ifNil: [ url := 'ws://gc.dcc.uchile.cl.:80' asZnUrl ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> url: aZnUrl [
	url := aZnUrl ifNotNil: [ aZnUrl asZnUrl ].
	self save.
]
