"
A GTSpotterEventRecorderSettings manages  user preferences related to  sending usage data.

Instance Variables
	computerUUID:		<Object>
	sendSearchQuery:		<Object>
	sendUsageData:		<Object>
	url:		<Object>
	userAnsweredAgreement:		<Object>

computerUUID
	- xxxxx

sendSearchQuery
	- xxxxx

sendUsageData
	- xxxxx

url
	- xxxxx

userAnsweredAgreement
	- xxxxx

"
Class {
	#name : #GTSpotterEventRecorderSettings,
	#superclass : #Object,
	#instVars : [
		'computerUUID',
		'sendUsageData',
		'persistSettings'
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
	| dictionary newInstance |
	self preferences exists ifFalse: [ 
		"This is a new computer, so we define new computer UUID.
		User still has to agree about sending data if it is not has been done yet."
		^ self savePreferences ].
	[ 
		dictionary := self new dictionary: (FLMaterializer materializeFromFileNamed: self preferences).
		newInstance := self new dictionary: dictionary.
		"If UUIDs are different, it is likely different user and we should use
		localy stored settings. If the UUIDs are same, we keep settings of the image."
		newInstance computerUUID = self uniqueInstance computerUUID
			ifFalse: [ uniqueInstance := newInstance ]
	] on: Error do: [ 
		"Preferences likely contains a different settings version, so we store the actual one.
		We should keep the preferences as stable as possible."
		self savePreferences ]
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
	[ FLSerializer serialize: self uniqueInstance dictionary toFileNamed: self preferences ]
		on: Error do: [ "ignore" ]
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
	"We reset image preferences, because this is likely 
	a newly downloaded image or different user
	and he/she should agree about sending data."
	self preferences exists ifFalse: [ self reset ].
	self loadPreferences.
]

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> stringUrl [
	^ self url asString
]

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> stringUrl: aUrlString [
	^ self url: aUrlString
]

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> url [
	^ url ifNil: [ url := 'http://gc.dcc.uchile.cl.:8080/gt/events' asZnUrl ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings class >> url: aZnUrl [
	url := aZnUrl ifNotNil: [ aZnUrl asZnUrl ].
	self save.
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> computerUUID [
	^ computerUUID
]

{ #category : #converting }
GTSpotterEventRecorderSettings >> dictionary [
	| dictionary |
	dictionary := Dictionary new: self class instSize.
	1 to: self class instSize do: [ :index |
		dictionary 
			at: (self class instVarNameForIndex: index)
			put: (self instVarAt: index)
	].
	^ dictionary
]

{ #category : #converting }
GTSpotterEventRecorderSettings >> dictionary: aCollection [ 
	aCollection keysAndValuesDo: [ :key :value | | instVarIndex |
		instVarIndex := self class instVarIndexFor: key.
		instVarIndex isZero ifFalse: [ 
			self instVarAt: instVarIndex put: value
		]
	]
]

{ #category : #initialization }
GTSpotterEventRecorderSettings >> initialize [
	super initialize.
	computerUUID := UUID new.
	
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> persistSettings [
	^ persistSettings ifNil: [ persistSettings := false ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> persistSettings: aBoolean [
	persistSettings := aBoolean.
	self save.
]

{ #category : #actions }
GTSpotterEventRecorderSettings >> save [
	self persistSettings ifFalse: [ ^ self ].
	self class savePreferences
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> sendUsageData [
	^ sendUsageData ifNil: [ sendUsageData := false ]
]

{ #category : #accessing }
GTSpotterEventRecorderSettings >> sendUsageData: aBoolean [
	sendUsageData := aBoolean.
	self save.
]
