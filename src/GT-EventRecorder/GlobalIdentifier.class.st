"
I keep global IDs that are used for tracking user activity, e.g. computer id. By default, you should access me by calling #uniqueInstance.

Responsibility:
The IDs that are important to store onto disk (and shared by all images) should be placed in persistedInformation instance variable. On other hand, if you do not want to store it onto disk, create a new instance variable. I can #loadPreferences and #savePreferences onto a disk.

I know computer ID and secret ID. Computer ID is a global UUID that is share among all the images. It is stored on a local disk. Secret ID is use for encrypting information, e.g., class names, method names. You can use #hashForText: method.

Collaborators: I do not collaborate with other classes. I only offer the basic IDs for other frameworks.

Public API and Key Messages

- computerUUID 
- ensureComputerUUID
- hashForText:
- loadPreferences 
- savePreferences.

Before using #computerUUID, you should call #ensureComputerUUID. It will update UUID from the disk or stores existing one if it is not stored yet. I behave like this as autonatically storing data to disk on image start-up leads to errors.

Internal Representation and Key Implementation Points.

    Instance Variables
	persistedInformation:		<Dictionary>
	preferences:		<FileReference>

"
Class {
	#name : #GlobalIdentifier,
	#superclass : #Object,
	#instVars : [
		'preferences',
		'persistedInformation'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-EventRecorder-Privacy'
}

{ #category : #cleanup }
GlobalIdentifier class >> cleanUp [
	"Clean unique instance."	
	self reset.
]

{ #category : #'instance creation' }
GlobalIdentifier class >> new [
	"Users should not create instances of this class.
	Within the framework more instances are created when loading data and when testing."
	self shouldNotImplement
]

{ #category : #'instance creation' }
GlobalIdentifier class >> persistedInformation: aDictionary [ 
	^ self basicNew initialize persistedInformation: aDictionary; yourself
]

{ #category : #'initialize-release' }
GlobalIdentifier class >> reset [
	"self reset"
	uniqueInstance := nil
]

{ #category : #accessing }
GlobalIdentifier class >> uniqueInstance [
	"self uniqueInstance"
	^ uniqueInstance ifNil: [ 
			uniqueInstance := self basicNew initialize ].
]

{ #category : #accessing }
GlobalIdentifier >> computerUUID [
	^ persistedInformation at: #computerUUID
]

{ #category : #'load and saving' }
GlobalIdentifier >> deletePreferences [
	"self deletePreferences"
	[ self preferences ensureDelete ]
	on: Error do: [ "ignore" ]
]

{ #category : #'load and saving' }
GlobalIdentifier >> ensureComputerUUID [
	self loadPreferences
]

{ #category : #'load and saving' }
GlobalIdentifier >> ensurePreferencesDirectory [
	self preferences parent ensureCreateDirectory 
]

{ #category : #accessing }
GlobalIdentifier >> hashForText: aString [
	^ aString hash bitXor: self secretUUID hash
]

{ #category : #initialization }
GlobalIdentifier >> initialize [
	super initialize.
	"Dictionary contains all the values that we want to persist on disk."
	persistedInformation := Dictionary new.
	persistedInformation at: #computerUUID put: UUID new.
	self secretUUID: UUID new.
]

{ #category : #'load and saving' }
GlobalIdentifier >> loadPreferences [
	"self uniqueInstance loadPreferences"
	self preferences exists ifFalse: [ 
		"This is a new computer, so we define new computer UUID.
		User still has to agree about sending data if it is not has been done yet."
		^ self savePreferences ].
	[ | newInstance |
		newInstance := self newInstanceFromPreferences.
		"If UUIDs are different, it is likely different user and we should use
		localy stored settings. If the UUIDs are same, we keep settings of the image."
		newInstance computerUUID = self computerUUID
			ifTrue: [ self secretUUID: newInstance secretUUID ]
			ifFalse: [ persistedInformation := newInstance persistedInformation ].
		self saveMissingAttributes: newInstance persistedInformation.
	] on: Error do: [ 
		"Preferences likely contains a different settings version, so we store the actual one.
		We should keep the preferences as stable as possible."
		self savePreferences ]
]

{ #category : #'instance creation' }
GlobalIdentifier >> newInstanceFromPreferences [
	| loadedDictionary |
	loadedDictionary := FLMaterializer materializeFromFileNamed: self preferences.
	^ self class persistedInformation: loadedDictionary.
]

{ #category : #accessing }
GlobalIdentifier >> persistedInformation [
	^ persistedInformation
]

{ #category : #accessing }
GlobalIdentifier >> persistedInformation: anObject [
	persistedInformation := anObject
]

{ #category : #accessing }
GlobalIdentifier >> preferences [
	"It is lazy initialized for the purpose of test cases."
	^ preferences ifNil: [ preferences := FileLocator preferences / 'org.pharo.gt.spotter.event.recorder.fuel' ]
]

{ #category : #accessing }
GlobalIdentifier >> preferences: aFileReference [
	"Set a preferences file. For testing purpose only."
	preferences := aFileReference 
]

{ #category : #'load and saving' }
GlobalIdentifier >> saveMissingAttributes: aDictionary [
	"It saves to the disk items that are included in the dictionary instance variable,
	but are missing in aDictionary. Useful when a new version of this class
	adds new configuration values that should be saved too."
	| difference |
	difference := aDictionary keys difference: persistedInformation keys.
	difference ifEmpty: [ ^ self ].
	difference do: [ :eachKey |
		persistedInformation at: eachKey put: (aDictionary at: eachKey) ].
	self savePreferences.
]

{ #category : #'load and saving' }
GlobalIdentifier >> savePreferences [
	"self savePreferences"
	self savePreferences: persistedInformation.
]

{ #category : #'load and saving' }
GlobalIdentifier >> savePreferences: aDictionary [
	self deletePreferences.
	self ensurePreferencesDirectory.
	self preferences writeStreamDo: [ :aPreferenceStream |
		aPreferenceStream binary.
		[ FLSerializer serialize: aDictionary on: aPreferenceStream ]
			on: Error do: [ :anError | "ignore" ] ]
]

{ #category : #accessing }
GlobalIdentifier >> secretUUID [
	^ persistedInformation at: #secretUUID
]

{ #category : #accessing }
GlobalIdentifier >> secretUUID: anUUID [
	^ persistedInformation at: #secretUUID put: anUUID
]
