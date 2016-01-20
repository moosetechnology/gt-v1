"
A helper class containing the help for GT Spotter.
"
Class {
	#name : #GTSpotterHelp,
	#superclass : #CustomHelp,
	#category : #'GT-Spotter'
}

{ #category : #accessing }
GTSpotterHelp class >> bookName [ 
	^'GT Spotter'
]

{ #category : #documentation }
GTSpotterHelp class >> keybindings [
	^ HelpTopic 
		title: 'Keybindings'
		contents: 
'Cmd+p - open/close the preview pane

Cmd+w / Esc - close Spotter

Up / Down - navigate through the search result list

Cmd+Shift+Up/Down - navigate through the search categories

Enter - triggers the default action on the selected object

Cmd+Right - dive in an object

Cmd+Left / Cmd+Shift+Left - dive out from an object into the previous step

Cmd+Shift+Right - dive in a category to see its elements'
]

{ #category : #documentation }
GTSpotterHelp class >> overview [
	^ HelpTopic 
		title: 'Overview'
		contents: 
'GT Spotter is a moldable object search tool that is part of Pharo and was developed as part of the Glamorous Toolkit project (http://gt.moosetechnology.org)'
]

{ #category : #accessing }
GTSpotterHelp class >> pages [
	^#(overview keybindings)
]
