"
KMRepository reset
"
Class {
	#name : #GTSpotterGlobalShortcut,
	#superclass : #KMCategory,
	#category : #'GT-Spotter-UI'
}

{ #category : #testing }
GTSpotterGlobalShortcut class >> isGlobalCategory [
	^ true
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> openGlobalSpotter [
	| spotterModel |
		
	self reset.
	spotterModel := GTSpotter new.
	(Smalltalk hasClassNamed: #GTSpotterEventRecorder) ifTrue: [ 
		#GTSpotterEventRecorder asClass instance 
			perform: #linkToSpotter: with: spotterModel;
			perform: #recordSpotterOpenEvent ] .
	
	GTSpotterMorph new
		extent: (World width / 2.4 @ (World height / 1.6)) asIntegerPoint;
		spotterModel: spotterModel;
		doLayout;
		openCenteredInWorld.
		
	spotterModel class markOpened.
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> openGlobalSpotterDebug [

	GTSpotterMorph new
		extent: 830@630;
		spotterModel: GTSpotter new;
		openInWindowLabeled: 'Spotter Debug Mode';
		showPreview
]

{ #category : #cleanup }
GTSpotterGlobalShortcut class >> reset [
	
	(World findA: GTSpotterMorph) ifNotNil: [ :aSpotterMorph | aSpotterMorph spotterModel exitDueTo: #reset ]
]

{ #category : #shortcuts }
GTSpotterGlobalShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr shift
			action: [ self class openGlobalSpotter ]
]

{ #category : #shortcuts }
GTSpotterGlobalShortcut >> keymapToggleDebug [
	"KMRepository reset"
	"<shortcut>"
	^ KMKeymap
			shortcut: Character cr command
			action: [ self class openGlobalSpotterDebug ]
]

{ #category : #accessing }
GTSpotterGlobalShortcut >> openGlobalSpotter [
	
]
