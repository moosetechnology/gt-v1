Extension { #name : #FAMIXType }

{ #category : #'*Moose-Finder' }
FAMIXType >> mooseFinderAttributesIn: composite [
	<moosePresentationOrder: 20>
	composite table
			title: 'Attributes';
			titleIcon: MooseIcons famixAttributeGroup;
			display: [ self attributes ];
			column: 'Name' evaluated: #name;
			column: 'Declared type' evaluated: [ :each | each declaredType mooseDisplayString ];
			column: 'Modifiers' evaluated: [ '' ] tags: #modifiers;
			when: [ self attributes notEmpty ];
			selectionPopulate: #selection  
				entitled: 'Open declared type' 
				with:  [ :table | table selection declaredType ]
]

{ #category : #'*Moose-Finder' }
FAMIXType >> mooseFinderBlueprintIn: composite [
	<moosePresentationOrder: 20>
	composite roassal2 
			title: 'Blueprint';
			titleIcon: MooseIcons mooseBlueprint;
			painting: [ :view :each | each mooseInterestingEntity viewBlueprintOn: view ]
]

{ #category : #'*Moose-Finder' }
FAMIXType >> mooseFinderMethodsIn: composite [
	<moosePresentationOrder: 20>
	composite table
			title: 'Methods';
			titleIcon: MooseIcons famixMethodGroup;
			display: [ self methods ];
			column: 'Name' evaluated: #signature;
			column: 'Declared type' evaluated: [ :each | each declaredType mooseDisplayString ];
			when: [ self methods notEmpty ];
			selectionPopulate: #selection  
				entitled: 'Open declared type' 
				with:  [ :table | table selection declaredType ]
]
