Extension { #name : #FM3PropertyDescription }

{ #category : #'*Moose-Finder' }
FM3PropertyDescription >> compiledMethod [

	^ self mmClass implementingClass methodDict at: self implementingSelector
]
