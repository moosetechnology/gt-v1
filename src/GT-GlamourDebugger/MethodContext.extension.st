Extension { #name : #MethodContext }

{ #category : #'*GT-GlamourDebugger' }
MethodContext >> locateBrowserContext [

	^ (self findContextSuchThat:  [ :ctx | 
		(ctx receiver class inheritsFrom: GLMPresentation)  and: [ ctx selector = #startOn: ] ]) 
]
