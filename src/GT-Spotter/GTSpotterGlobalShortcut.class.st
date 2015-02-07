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

{ #category : #testing }
GTSpotterGlobalShortcut class >> isGlobalCategory [
	^ true
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> openGlobalSpotter [
	globalSpotter 
		ifNotNil: [ globalSpotter delete ].
		
	globalSpotter := GTSpotterMorph new
		extent: (World width / 2.4 @ (World height / 1.6)) asIntegerPoint;
		spotterModel: GTSpotter new;
		doLayout;
		openCenteredInWorld.
		
	^ globalSpotter
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> openGlobalSpotterDebug [
	<example>
		
	GTSpotterMorph new
		extent: 830@630;
		spotterModel: GTSpotter new;
		openInWindowLabeled: 'Spotter Debug Mode';
		showPreview
]

{ #category : #'as yet unclassified' }
GTSpotterGlobalShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr shift
			action: [ self class openGlobalSpotter ]
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
