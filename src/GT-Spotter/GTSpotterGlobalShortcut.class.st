"
KMRepository reset
"
Class {
	#name : #GTSpotterGlobalShortcut,
	#superclass : #KMCategory,
	#classInstVars : [
		'globalSpotter'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #cleanup }
GTSpotterGlobalShortcut class >> cleanUp [
	self reset
]

{ #category : #testing }
GTSpotterGlobalShortcut class >> isGlobalCategory [
	^ true
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> openGlobalSpotter [
	|spotterModel|
	globalSpotter 
		ifNotNil: [ globalSpotter spotterModel exit ].
		
	spotterModel := GTSpotter new.
	(Smalltalk hasClassNamed: #GTSpotterEventRecorder) ifTrue: [ 
		#GTSpotterEventRecorder asClass instance 
			perform: #linkToSpotter: with: spotterModel;
			perform: #recordSpotterOpenEvent ] .
	
	globalSpotter := GTSpotterMorph new
		extent: (World width / 2.4 @ (World height / 1.6)) asIntegerPoint;
		spotterModel: spotterModel;
		doLayout;
		openCenteredInWorld.
		
	spotterModel class markOpened.
	^ globalSpotter
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> openGlobalSpotterDebug [

	GTSpotterMorph new
		extent: 830@630;
		spotterModel: GTSpotter new;
		openInWindowLabeled: 'Spotter Debug Mode';
		showPreview
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> reset [
	"
	self reset
	"
	globalSpotter := nil
]

{ #category : #'as yet unclassified' }
GTSpotterGlobalShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr shift
			action: [ self class openGlobalSpotter spotterModel shiftPressed: true ]
]

{ #category : #'as yet unclassified' }
GTSpotterGlobalShortcut >> keymapToggleDebug [
	"KMRepository reset"
	"<shortcut>"
	^ KMKeymap
			shortcut: Character cr command
			action: [ self class openGlobalSpotterDebug ]
]

{ #category : #'as yet unclassified' }
GTSpotterGlobalShortcut >> openGlobalSpotter [
	
]
