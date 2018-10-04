"
This holds the global keymapping for triggering the presenter note.

To make it take effect execute:
KMRepository reset.
"
Class {
	#name : #GTPresenterShortcuts,
	#superclass : #KMCategory,
	#category : #'GT-PresenterNote'
}

{ #category : #'as yet unclassified' }
GTPresenterShortcuts class >> isGlobalCategory [

	^ true
]

{ #category : #'as yet unclassified' }
GTPresenterShortcuts >> keymapToggle [
	<shortcut>
	^ KMKeymap
			shortcut: $/ command
			action: [ 
				GTPresenterNoteEditingArea new
					beWrapped;
					width: World width / 3;
					updateTextWith: '';
					takeKeyboardFocus;
					backgroundColor: Color paleYellow;
					cellInset: 50;
					onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ];
					font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 20);
					openCenteredInWorld ]
]
