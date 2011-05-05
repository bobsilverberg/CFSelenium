<cfcomponent extends="mxunit.framework.TestCase">

	<cfset seleniumServer = createObject("component", "cfselenium.server").init()>
	
	<!--- NOTE: the server object will only start and stop the server if it was not already running --->
		
	<cffunction name="beforeTests" output="false" access="public" returntype="any" hint="">
		<cfset seleniumServer.startServer()>
	</cffunction>

	<cffunction name="afterTests" output="false" access="public" returntype="any" hint="">
		<cfset seleniumServer.stopServer()>
	</cffunction>
	
	<cffunction name="setUp" output="false" access="public" returntype="any" hint="">    
    	<!--- we rely on subclasses to specify browser URL OR override this and create a variable named selenium --->
    	<cfset selenium = startFirefox(browserUrl)>
    </cffunction>
	
	<cffunction name="tearDown" output="false" access="public" returntype="any" hint="">   
    	<cfset selenium.stop()>
    	<cfset assertEquals(0, len(selenium.getSessionId()))>
    </cffunction>
    
    <cffunction name="startSelenium" output="false" access="private" returntype="any" hint="">    
    	<cfargument name="browserURL" type="string" required="true"/>
		<cfargument name="browserCommand" type="string" required="false" default="*firefox"/>
       	<cfset variables.selenium = createobject("component","CFSelenium.selenium").init(browserUrl,"localhost", 4444, browserCommand)>
       	<cfset assertEquals(0, len(selenium.getSessionId()))>
        <cfset selenium.start()>
	    <cfset assertFalse(len(selenium.getSessionId()) eq 0)>
	    <cfreturn selenium>
    </cffunction>

	<cffunction name="startFirefox" output="false" access="private" returntype="any" hint="">   
		<cfargument name="browserURL" type="string" required="true"/> 
    	<cfreturn startSelenium(browserURL, "*firefox")>
    </cffunction>
</cfcomponent>