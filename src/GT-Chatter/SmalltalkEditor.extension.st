Extension { #name : #SmalltalkEditor }

{ #category : #'*GT-Chatter' }
SmalltalkEditor class >> chatterEditorMenuOn: aBuilder [
	"Specify the menu used when writing code. Try it with:
	(PragmaMenuBuilder 
		pragmaKeyword: 'smalltalkEditorMenu'
		model: nil) menu popUpInWorld
	"
	<contextMenu>
	<smalltalkEditorMenu>
	
	aBuilder
				item: 'Chat about it'; 
				selector: #chatAboutIt;
				order: 0.
]
