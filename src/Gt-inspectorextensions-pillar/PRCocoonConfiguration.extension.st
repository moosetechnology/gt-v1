Extension { #name : #PRCocoonConfiguration }

{ #category : #'*GT-InspectorExtensions-Pillar' }
PRCocoonConfiguration >> gtInspectorInputFilesIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite list 
		title: 'Files';
		display: [self inputFiles];
		format: #basename;
		act: [
			| c | 
			c := self propertyAt: 'configurations' ifAbsent: [ #() ].
			c isEmpty 
				ifTrue: [ self export ] 
				ifFalse: [ c do: #export ] ] 
			icon: GLMUIThemeExtraIcons glamorousPlay 
			entitled: 'Export'
]
