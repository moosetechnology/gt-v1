"
A helper class containing the help for GT Inspector.

I dynamically build and display  the list of extensions available for GT Inspector
"
Class {
	#name : #GTInspectorHelp,
	#superclass : #CustomHelp,
	#category : #'GT-Inspector'
}

{ #category : #accessing }
GTInspectorHelp class >> bookName [ 
	^'GT Inspector'
]

{ #category : #documentation }
GTInspectorHelp class >> extensions [
		
	^ HelpTopic 
		title: 'Extensions'
		contents: 'Inspector allows the developer to define custom presentations in different classes. These custom presentations take effect when the Inspector reaches an instance of the extended class. You can find below the list of extensions from this image.
		
You can also browse this list by inspecting:

		GTInspector inspectorExtendingMethods

', self extensionsString
]

{ #category : #documentation }
GTInspectorHelp class >> extensionsString [
	| methods title |
	^ String streamContents: [ :s |
		((GTInspector inspectorExtendingMethods groupedBy: #methodClass)
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
GTInspectorHelp class >> key [
	^ self name
]

{ #category : #documentation }
GTInspectorHelp class >> overview [
	^ HelpTopic 
		title: 'Overview'
		contents: 
'GT Inspector is a moldable inspector that is part of Pharo and was developed as part of the Glamorous Toolkit project (http://gt.moosetechnology.org)'
]

{ #category : #accessing }
GTInspectorHelp class >> pages [
	^#(overview table extensions)
]

{ #category : #documentation }
GTInspectorHelp class >> table [
	^ HelpTopic 
		title: 'Table'
		contents: 
'A table is a presentation that simply list elements. For example, you can create a table presentation for the class OrderedCollection by defining the following method in OrderedCollection:
-=-=-=-=
gtInspectorTableIn: composite
	<gtInspectorPresentationOrder: -15>
	composite table
		title: ''Table'';
		display: [ self collect: #asString ]
-=-=-=-=

Inspect the expression:
((1 to: 5), (1 to: 5), (1 to: 5)) asOrderedCollection

You will have a list of numbers.

'
]
