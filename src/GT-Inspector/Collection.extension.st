Extension { #name : #Collection }

{ #category : #'*gt-inspector' }
Collection >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 30>  
	 (composite list)
		title: [ :anObject | anObject size asString , ' items' ];
		format: [ :assoc |
			[ Text fromString: assoc asString ] 
							on: Error 
							do: [ Text string: 'error printing' attribute: TextColor red ] ];
		icon: [ :each |  OBMorphicIcons iconNamed: each class theNonMetaClass browserIcon ];
		showOnly: 50 
]
