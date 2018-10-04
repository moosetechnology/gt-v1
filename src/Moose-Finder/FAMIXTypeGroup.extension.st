Extension { #name : #FAMIXTypeGroup }

{ #category : #'*moose-finder' }
FAMIXTypeGroup >> browseAsSelectionInSystemComplexityLocator [
	<menuItem: 'As selection within system complexity' category: 'Browse'> 
	MooseSystemComplexityLocator openOn: self mooseModel allModelClasses withSelection: self
]

{ #category : #'*moose-finder' }
FAMIXTypeGroup >> mooseFinderComplexityIn: composite [
	<moosePresentationOrder: 20>
	composite roassal2
			title: 'Complexity';
			titleIcon: MooseIcons mooseSystemComplexity;
			initializeView: [ RTMondrianViewBuilder new ];
			painting: [ :view :each | 
				each mooseInterestingEntity viewSimpleSystemComplexityOn: view ]

]

{ #category : #'*moose-finder' }
FAMIXTypeGroup >> mooseFinderWithinNestedMapIn: composite [
	<moosePresentationOrder: 30>
	composite roassal2
			title: 'Nesting';
			titleIcon: MooseIcons mooseTreeMap;
			painting: [ :view :each | 
				each mooseInterestingEntity viewSystemNestingMapOnRaw: view ]

]

{ #category : #'*moose-finder' }
FAMIXTypeGroup >> mooseIcon [
	^ MooseIcons famixClassGroup 
]

{ #category : #'*moose-finder' }
FAMIXTypeGroup >> viewSystemComplexityInWizard [
	<menuItem: 'Customizable System Complexity' category: 'Visualize'>
	self isEmpty ifTrue: [ ^ self ].
	^ MooseCustomizableSystemComplexityBrowser 
					openOnClassGroup: self
					heightToSelect: #numberOfMethods
					widthToSelect: #numberOfAttributes
					colorToSelect: #numberOfLinesOfCode
]
