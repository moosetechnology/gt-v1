"
A helper class containing the help for GT Spotter.

I dynamically build and display  the list of extensions available for GT Spotter
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
GTSpotterHelp class >> extensions [
		
	^ HelpTopic 
		title: 'Extensions'
		contents: 'Spotter allows the developer to define custom search processors in different classes. These custom processors take effect when Spotter reaches an instance of the extended class. You can find below the list of extensions from this image.
		
You can also browse this list by inspecting:

		GTSpotter spotterExtendingMethods

', self extensionsString
]

{ #category : #documentation }
GTSpotterHelp class >> extensionsString [
	| methods title |
	^ String streamContents: [ :s |
		((GTSpotter spotterExtendingMethods groupedBy: #methodClass) 
		associations sorted: [ :a :b | a key name < b key name ]) 
		do: [ :classMethodsAssociation |
			s nextPutAll: classMethodsAssociation key name; cr.
			methods := classMethodsAssociation value.
			methods do: [ :each | 
				title := each ast allChildren 
					detect: [ :node | node isMessage and: [ node selector = #title: ] ]
					ifFound: [ :node | node arguments first value. ]
					ifNone: [ each selector ].
				title isString ifFalse: [ title := each selector ].
				s 
					nextPutAll: '- '; 
					nextPutAll: title; 
					nextPutAll: ' ('; 
					nextPutAll: each selector; 
					nextPut: $);
					cr ].
			s cr ] ]
]

{ #category : #accessing }
GTSpotterHelp class >> key [
	^ self name
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
'GT Spotter is a moldable object search tool that is part of Pharo and was developed as part of the Glamorous Toolkit project (http://gt.moosetechnology.org).

Its goal is to help developers find and navigate through all sorts of objects, including packages, classes, methods, code snippets, or menus.'
]

{ #category : #accessing }
GTSpotterHelp class >> pages [
	^#(overview keybindings extensions)
]
