Extension { #name : #String }

{ #category : #'*gt-inspector' }
String >> gtInspectorITextIn: composite [
	<gtInspectorPresentationOrder: 30>  
	 composite text
		title: 'String'
]

{ #category : #'*gt-inspector' }
String >> gtInspectorItemsIn: composite [
	"We do not offer the list of items for a String"
	^ (self asOrderedCollection gtInspectorItemsIn: composite)
		title: [ :anObject | anObject size asString, ' chars' ];
		format: [ :each |
			[ each printString ] 
							on: Error 
							do: [ Text string: 'error printing' attribute: TextColor red ] ]
]
