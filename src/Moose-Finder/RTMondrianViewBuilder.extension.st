Extension { #name : #RTMondrianViewBuilder }

{ #category : #'*Moose-Finder' }
RTMondrianViewBuilder classSide >> mooseFinderMondrianExamplesIn: composite [
	<moosePresentationOrder: 0>
	^ (RTMondrianExample new gtInspectorPreviewIn: composite)
		titleIcon: MooseIcons mooseEg
]
