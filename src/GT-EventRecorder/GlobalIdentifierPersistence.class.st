Class {
	#name : #GlobalIdentifierPersistence,
	#superclass : #Object,
	#instVars : [
		'preferences',
		'previousPersistence'
	],
	#category : #'GT-EventRecorder-Identifiers'
}

{ #category : #'instance creation' }
GlobalIdentifierPersistence class >> fuel [
	^ GlobalIdentifierFuelPersistence new
]

{ #category : #'instance creation' }
GlobalIdentifierPersistence class >> ston [
	^ GlobalIdentifierStonPersistence new
]

{ #category : #configuration }
GlobalIdentifierPersistence >> defaultPreferences [
	^ FileLocator preferences / self fileName
]

{ #category : #operations }
GlobalIdentifierPersistence >> delete [
	"self deletePreferences"
	[ self preferences ensureDelete ]
	on: Error do: [ "ignore" ]
]

{ #category : #'load and saving' }
GlobalIdentifierPersistence >> ensure: existingDictionary [
	"It proceeds all backward compatibility work."
	self shouldCallPreviousPersistence ifTrue: [ 
		previousPersistence ensure: existingDictionary ].
	self load: existingDictionary
]

{ #category : #operations }
GlobalIdentifierPersistence >> ensureDirectory [
	self preferences parent ensureCreateDirectory 
]

{ #category : #configuration }
GlobalIdentifierPersistence >> fileName [
	^ self subclassResponsibility
]

{ #category : #'load and saving' }
GlobalIdentifierPersistence >> load [
	"It loads and returns stored dictionary."
	^ self subclassResponsibility
]

{ #category : #'load and saving' }
GlobalIdentifierPersistence >> load: existingDictionary [
	"It loads stored information into existingDictionary."
	self preferences exists ifFalse: [
		"This is a new computer, so we define new computer UUID.
		User still has to agree about sending data if it is not has been done yet."
		^ self save: existingDictionary ].
	[ (self mergeExisting: existingDictionary stored: self load)
			ifTrue: [ self save: existingDictionary ].
	] on: Error do: [ 
		"Preferences likely contains a different settings version, so we store the actual one.
		We should keep the preferences as stable as possible."
		self save: existingDictionary ]
]

{ #category : #merging }
GlobalIdentifierPersistence >> mergeExisting: existingDictionary stored: storedDictionary [
	^ GlobalIdentifierMerger new
			existing: existingDictionary;
			stored: storedDictionary;
			merge
]

{ #category : #accessing }
GlobalIdentifierPersistence >> preferences [
	^ preferences ifNil: [ preferences := self defaultPreferences ]
]

{ #category : #accessing }
GlobalIdentifierPersistence >> preferences: anObject [
	preferences := anObject
]

{ #category : #accessing }
GlobalIdentifierPersistence >> previous [
	^ previousPersistence
]

{ #category : #accessing }
GlobalIdentifierPersistence >> previous: aGlobalIdentifierPersistence [
	previousPersistence := aGlobalIdentifierPersistence
]

{ #category : #'load and saving' }
GlobalIdentifierPersistence >> save: aDictionary [
	self delete.
	self ensureDirectory.
	self preferences writeStreamDo: [ :aPreferenceStream | 
			self save: aDictionary into: aPreferenceStream ]
]

{ #category : #'load and saving' }
GlobalIdentifierPersistence >> save: aDictionary into: aWriteStream [
	"Saves aDictionary into aWriteStream"
	self subclassResponsibility
]

{ #category : #testing }
GlobalIdentifierPersistence >> shouldCallPreviousPersistence [
	^ self preferences exists not and: [ previousPersistence notNil ]
]
