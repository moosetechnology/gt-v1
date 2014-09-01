Extension { #name : #FileReference }

{ #category : #'*GT-InspectorExtensions-Pillar' }
FileReference >> gtInspectorPillarConfigurationIn: composite [
	<gtInspectorPresentationOrder: 40>
	(self basename = 'pillar.conf')
		ifFalse: [ ^ self ].
	((PRSTONConfigurationInterpreter baseDirectory: self parent)
		buildFromFile: self)
			gtInspectorInputFilesIn: composite
]

{ #category : #'*GT-InspectorExtensions-Pillar' }
FileReference >> gtInspectorPillarIn: composite [
	<gtInspectorPresentationOrder: 40>
	(#('pier' 'pillar') includes: self extension)
		ifFalse: [ ^ self ].
	
	composite custom: (GLMRubricHighlightedTextPresentation new
		title: 'Pillar';
		editingMode: [ : rubPresentation |
			GLMHighlighterTextRubEditingMode forStyler: (GTPillarHighlighterTextDecorator inPresentation: rubPresentation)];
		display: [ self readStreamDo: #contents ];
		act: [:rub | 
			self 
				ensureDelete; 
				writeStreamDo: [ :s | s nextPutAll: rub text asString ]] 
			icon: GLMUIThemeExtraIcons glamorousSave 
			on: $s 
			entitled: 'Save')
]

{ #category : #'*GT-InspectorExtensions-Pillar' }
FileReference >> gtInspectorPillarProjectIn: composite [
	<gtInspectorPresentationOrder: 20>
	(self isDirectory not or: [
	(self files noneSatisfy: [:each | each basename = 'pillar.conf'])])
		ifTrue: [ ^ self ].
	(((PRSTONConfigurationInterpreter baseDirectory: self)
		buildFromFile: (self files detect: [:each | each basename = 'pillar.conf']))
			gtInspectorInputFilesIn: composite)
			title: 'Pillar'
]
