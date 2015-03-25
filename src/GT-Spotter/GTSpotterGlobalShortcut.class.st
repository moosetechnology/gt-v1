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
	|spotterModel globalSpotter|
		
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

{ #category : #shortcuts }
GTSpotterGlobalShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr shift
			action: [ self class openGlobalSpotter spotterModel shiftPressed: true ]
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
