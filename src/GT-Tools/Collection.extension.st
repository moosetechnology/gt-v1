Extension { #name : #Collection }

{ #category : #'*gt-tools' }
Collection >> objectFinderItemsIn: composite [
	<objectFinderPresentationOrder: 30>  
	 (composite list)
		title: [ :anObject | anObject size asString , ' items' ];
		icon: [ :each |  OBMorphicIcons iconNamed: each class theNonMetaClass browserIcon ];
		showOnly: 20 
]
