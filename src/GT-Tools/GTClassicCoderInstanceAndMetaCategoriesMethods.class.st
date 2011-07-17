"
| browser |
browser := self new browser.
(browser pane port: #entity) value: {RPackageOrganizer default packages last . RPackageOrganizer default packages last classes anyOne}.
browser open
"
Class {
	#name : #GTClassicCoderInstanceAndMetaCategoriesMethods,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Prototypes-Coder'
}

{ #category : #building }
GTClassicCoderInstanceAndMetaCategoriesMethods >> buildBrowser [
	browser := GLMStacker new.
	browser aPane: #instance; aPane: #meta.
	browser transmit
		when: [ :packageClass | packageClass last notNil ];
		to: #instance;
		andShow: [ :a | 
					a title: 'Instance'.
					a custom: GTClassicCoderCategoriesMethods new browser ].
	(browser transmit)
		transformed: [ :packageClass | packageClass last ifNotNil: [ {packageClass first. packageClass last theMetaClass} ] ];
		when: [ :packageClass | packageClass last notNil ];
		to: #meta;
		andShow: [ :a | 
					a title: 'Meta'.
					a custom: GTClassicCoderCategoriesMethods new browser ].
	(browser transmit)
		toOutsidePort: #selectedMethod;
		from: #instance port: #selectedMethod.
	(browser transmit)
		toOutsidePort: #selectedMethod;
		from: #meta port: #selectedMethod.
	^ browser
]
