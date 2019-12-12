<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes" 
 xmlns:xdtOld="http://www.w3.org/2005/02/xpath-datatypes" 
 xmlns:xdtOld2="http://www.w3.org/2004/10/xpath-datatypes" 
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs xdt f"
>

 <xsl:import href="func-curry.xsl"/>
 <xsl:import href="func-compose-flist.xsl"/>
 
<!--
       This module contains the FXSL versions of the "standard" XPath functions
                                                                               
       These are intended as convenience functions, so that they can be passed 
       as parameters to other functions (e.g. to f:zipWith())                  
       or curried and passed as parameters (e.g. to f:map())                   
-->

<!--
       Arithmetic functions: abs(), ceiling(), floor(), round(),               
       round-half-to-even()                                                    
-->


 <xsl:template match="f:abs" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:abs($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:abs" as="element()">
   <f:abs/>
 </xsl:function>
 

 <xsl:function name="f:abs" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="abs($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:ceiling" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:ceiling($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:ceiling" as="element()">
   <f:ceiling/>
 </xsl:function>
 

 <xsl:function name="f:ceiling" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="ceiling($arg1)"/>
 </xsl:function>


 <xsl:template match="f:floor" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:floor($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:floor" as="element()">
   <f:floor/>
 </xsl:function>
 

 <xsl:function name="f:floor" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="floor($arg1)"/>
 </xsl:function>


 <xsl:template match="f:round" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:round($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:round" as="element()">
  <f:round/>
 </xsl:function>
 

 <xsl:function name="f:round" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="round($arg1)"/>
 </xsl:function>
   


 <xsl:template match="f:round-half-to-even" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:round-half-to-even($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:round-half-to-even" as="element()">
  <f:round-half-to-even/>
 </xsl:function>
 

 <xsl:function name="f:round-half-to-even" as="node()">
   <xsl:param name="arg1" as="item()"/>
   
   <xsl:sequence select="f:curry(f:round-half-to-even(), 2, $arg1)"/>
 </xsl:function>
   
 <xsl:function name="f:round-half-to-even" as="item()?">
   <xsl:param name="arg1" as="item()?"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="round-half-to-even($arg1,$arg2)"/>
 </xsl:function>
   
<!--
       Boolean functions: not()                                                
-->


 <xsl:template match="f:not" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:not($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:not" as="element()">
  <f:not/>
 </xsl:function>
 
 <xsl:function name="f:not" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="not($arg1)"/>
 </xsl:function>
   
<!--
       String functions: string-join(), substring()                            
                         string-length(), normalize-space()                    
                         normalize-unicode(), upper-case(),                    
                         lower-case(), translate(), escape-uri()               
-->
   

 <xsl:template match="f:string-join" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string*"/>
   <xsl:param name="arg2" as="xs:string*"/>
   
   <xsl:sequence select="f:string-join($arg1, if(empty($arg2)) then '' else $arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:string-join" as="element()">
  <f:string-join/>
 </xsl:function>
 

 <xsl:function name="f:string-join" as="node()">
   <xsl:param name="arg1" as="xs:string*"/>
   
   <xsl:sequence select="f:curry(f:string-join(), 2, $arg1)"/>
 </xsl:function>
   
 <xsl:function name="f:string-join" as="xs:string">
   <xsl:param name="arg1" as="xs:string*"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="string-join($arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:template match="f:substring" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="f:substring($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:substring" as="element()">
  <f:substring/>
 </xsl:function>
 

 <xsl:function name="f:substring" as="node()">
   <xsl:param name="arg1" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:substring(), 3, $arg1)"/>
 </xsl:function>
   
 <xsl:function name="f:substring" as="xs:string">
   <xsl:param name="arg1" as="xs:string"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="substring($arg1,$arg2,$arg3)"/>
 </xsl:function>
 
 <xsl:template match="f:string-length" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:string-length($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:string-length" as="element()">
   <f:string-length/>
 </xsl:function>
 
 <xsl:function name="f:string-length" as="xs:integer">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="string-length($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:normalize-space" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:normalize-space($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:normalize-space" as="element()">
   <f:normalize-space/>
 </xsl:function>
 
 <xsl:function name="f:normalize-space" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="normalize-space($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:normalize-unicode" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:normalize-unicode($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:normalize-unicode" as="element()">
   <f:normalize-unicode/>
 </xsl:function>
 
 <xsl:function name="f:normalize-unicode" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:normalize-unicode(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:normalize-unicode" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="normalize-unicode($arg1,$arg2)"/>
 </xsl:function>
 

 <xsl:template match="f:upper-case" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:upper-case($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:upper-case" as="element()">
   <f:upper-case/>
 </xsl:function>
 
 <xsl:function name="f:upper-case" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="upper-case($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:lower-case" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:lower-case($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:lower-case" as="element()">
   <f:lower-case/>
 </xsl:function>
 
 <xsl:function name="f:lower-case" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="lower-case($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:translate" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:translate($arg1,$arg2,arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:translate" as="element()">
   <f:translate/>
 </xsl:function>
 
 <xsl:function name="f:translate" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:translate(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:translate" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:translate(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:translate" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="translate($arg1,$arg2,$arg3)"/>
 </xsl:function>
<!-- 
 <f:escape-uri/>
 <xsl:template match="f:escape-uri" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:boolean"/>
   
   <xsl:sequence select="f:escape-uri($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:escape-uri" as="node()">
   <xsl:sequence select="document('')/*/f:escape-uri[1]"/>
 </xsl:function>
 
 <xsl:function name="f:escape-uri" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:escape-uri(),2,$arg1)"/>
 </xsl:function>
 

 <xsl:function name="f:escape-uri" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:boolean"/>
   
   <xsl:sequence select="escape-uri($arg1,$arg2)"/>
 </xsl:function>
--> 
<!--
  More String functions: contains(), starts-with()                             
                         ends-with(), substring-before(),                      
                         substring-after()                                     
-->

 <xsl:template match="f:contains" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:contains($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:contains" as="element()">
   <f:contains/>
 </xsl:function>
 
 <xsl:function name="f:contains" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:contains(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:contains" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="contains($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:starts-with" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:starts-with($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:starts-with" as="element()">
   <f:starts-with/>
 </xsl:function>
 
 <xsl:function name="f:starts-with" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:starts-with(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:starts-with" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="starts-with($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:ends-with" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:ends-with($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:ends-with" as="element()">
   <f:ends-with/>
 </xsl:function>
 
 <xsl:function name="f:ends-with" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:ends-with(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:ends-with" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="ends-with($arg1,$arg2)"/>
 </xsl:function>
    

 <xsl:template match="f:substring-before" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>

   <xsl:sequence select="f:substring-before($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:substring-before" as="element()">
   <f:substring-before/>
 </xsl:function>
 
 <xsl:function name="f:substring-before" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:substring-before(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:substring-before" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="substring-before($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:substring-after" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="f:substring-after($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:substring-after" as="element()">
   <f:substring-after/>
 </xsl:function>
 
 <xsl:function name="f:substring-after" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:substring-after(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:substring-after" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   
   <xsl:sequence select="substring-after($arg1,$arg2)"/>
 </xsl:function>
    
<!--
  More String functions: matches(), replace(), tokenize()                      
                                                                               
-->

 <xsl:template match="f:matches" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:matches($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:matches" as="element()">
   <f:matches/>
 </xsl:function>
 
 <xsl:function name="f:matches" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:matches(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:matches" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:matches(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:matches" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="matches($arg1,$arg2,$arg3)"/>
 </xsl:function>
    
 <xsl:template match="f:replace" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   <xsl:param name="arg4" as="xs:string"/>
   
   <xsl:sequence select="f:replace($arg1,$arg2,$arg3,$arg4)"/>
 </xsl:template>
 
 <xsl:function name="f:replace" as="element()">
   <f:replace/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:replace(),4,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:replace(),4,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:replace(),4,$arg1,$arg2,$arg3)"/>
 </xsl:function>
 
 <xsl:function name="f:replace" as="xs:string">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   <xsl:param name="arg3" as="xs:string"/>
   <xsl:param name="arg4" as="xs:string"/>
   
   <xsl:sequence select="replace($arg1,$arg2,$arg3,$arg4)"/>
 </xsl:function>

 <xsl:template match="f:tokenize" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="f:tokenize($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:tokenize" as="element()">
   <f:tokenize/>
 </xsl:function>
 
 <xsl:function name="f:tokenize" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:tokenize(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:tokenize" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:curry(f:tokenize(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:tokenize" as="xs:string+">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="xs:string?"/>
   <xsl:param name="arg3" as="xs:string"/>
   
   <xsl:sequence select="tokenize($arg1,$arg2,$arg3)"/>
 </xsl:function>

<!--
       Functions on nodes: name(), local-name()                                
                         namespace-uri(), number(),                            
                         lang(), root()                                        
-->

 <xsl:template match="f:name" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:name($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:name" as="node()">
   <f:name/>
 </xsl:function>
 
 <xsl:function name="f:name" as="xs:string">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="name($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:local-name" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:local-name($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:local-name" as="node()">
   <f:local-name/>
 </xsl:function>
 
 <xsl:function name="f:local-name" as="xs:string">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="local-name($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:namespace-uri" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:namespace-uri($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:namespace-uri" as="element()">
   <f:namespace-uri/>
 </xsl:function>
 
 <xsl:function name="f:namespace-uri" as="xs:anyURI">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="namespace-uri($arg1)"/>
 </xsl:function>
 

 <xsl:template match="f:number" mode="f:FXSL">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="f:number($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:number" as="element()">
   <f:number/>
 </xsl:function>
 
 <xsl:function name="f:number" as="xs:double">
   <xsl:param name="arg1" as="item()?"/>
   
   <xsl:sequence select="number($arg1)"/>
 </xsl:function>

 <xsl:template match="f:lang" mode="f:FXSL">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="node()"/>
   
   <xsl:sequence select="f:lang($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:lang" as="element()">
   <f:lang/>
 </xsl:function>
 
 <xsl:function name="f:lang" as="node()">
   <xsl:param name="arg1" as="xs:string?"/>
   
   <xsl:sequence select="f:curry(f:lang(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:lang" as="xs:boolean">
   <xsl:param name="arg1" as="xs:string?"/>
   <xsl:param name="arg2" as="node()"/>
   
   <xsl:sequence select="lang($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:root" mode="f:FXSL">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="f:root($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:root" as="element()">
   <f:root/>
 </xsl:function>
 
 <xsl:function name="f:root" as="node()?">
   <xsl:param name="arg1" as="node()?"/>
   
   <xsl:sequence select="root($arg1)"/>
 </xsl:function>
 
<!--
       Functions on sequences:                                                 
                         boolean(), index-of(),                                
                         empty(), exists(),                                    
                         distinct-values(), insert-before(),                   
                         remove(), reverse(),                                  
                         subsequence(), unordered()                            
-->

 <xsl:template match="f:boolean" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:boolean($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:boolean" as="element()">
   <f:boolean/>
 </xsl:function>
 
 <xsl:function name="f:boolean" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="boolean($arg1)"/>
 </xsl:function>
 
 <xsl:template match="f:index-of" mode="f:FXSL">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   <xsl:param name="arg2" as="xdt:anyAtomicType"/>
   
   <xsl:sequence select="f:index-of($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:index-of" as="element()">
   <f:index-of/>
 </xsl:function>
 
 <xsl:function name="f:index-of" as="node()">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="f:curry(f:index-of(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:index-of" as="xs:integer*">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   <xsl:param name="arg2" as="xdt:anyAtomicType"/>
   
   <xsl:sequence select="index-of($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:empty" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:empty($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:empty" as="element()">
   <f:empty/>
 </xsl:function>
 
 <xsl:function name="f:empty" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="empty($arg1)"/>
 </xsl:function>
     
 <xsl:template match="f:exists" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:exists($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:exists" as="element()">
   <f:exists/>
 </xsl:function>
 
 <xsl:function name="f:exists" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="exists($arg1)"/>
 </xsl:function>
     
 <xsl:template match="f:distinct-values" mode="f:FXSL">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="f:distinct-values($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:distinct-values" as="element()">
   <f:distinct-values/>
 </xsl:function>
 
 <xsl:function name="f:distinct-values" as="xdt:anyAtomicType*">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="distinct-values($arg1)"/>
 </xsl:function>

 <xsl:template match="f:insert-before" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   <xsl:param name="arg3" as="item()*"/>
   
   <xsl:sequence select="f:insert-before($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:insert-before" as="element()">
   <f:insert-before/>
 </xsl:function>
 
 <xsl:function name="f:insert-before" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:insert-before(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:insert-before" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:curry(f:insert-before(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:insert-before" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   <xsl:param name="arg3" as="item()*"/>
  
   <xsl:sequence select="insert-before($arg1,$arg2,$arg3)"/>
 </xsl:function>

 <xsl:template match="f:remove" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="f:remove($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:remove" as="element()">
   <f:remove/>
 </xsl:function>
 
 <xsl:function name="f:remove" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:remove(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:remove" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:integer"/>
   
   <xsl:sequence select="remove($arg1,$arg2)"/>
 </xsl:function>
    
 <xsl:template match="f:x-reverse" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:x-reverse($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-reverse" as="element()">
   <f:x-reverse/>
 </xsl:function>
 
 <xsl:function name="f:x-reverse" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="reverse($arg1)"/>
 </xsl:function>

 <xsl:template match="f:subsequence" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="f:subsequence($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
 <xsl:function name="f:subsequence" as="element()">
   <f:subsequence/>
 </xsl:function>
 
 <xsl:function name="f:subsequence" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:subsequence(),3,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:subsequence" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:double"/>
   
   <xsl:sequence select="f:curry(f:subsequence(),3,$arg1,$arg2)"/>
 </xsl:function>
 
 <xsl:function name="f:subsequence" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="xs:double"/>
   <xsl:param name="arg3" as="xs:double"/>
   
   <xsl:sequence select="subsequence($arg1,$arg2,$arg3)"/>
 </xsl:function>

 <xsl:template match="f:unordered" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:unordered($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:unordered" as="element()">
   <f:unordered/>
 </xsl:function>
 
 <xsl:function name="f:unordered" as="item()*">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="unordered($arg1)"/>
 </xsl:function>

<!--
       Functions on sequences:                                                 
                 zero-or-one(), one-or-more(), exactly-one()                   
-->

 <xsl:template match="f:zero-or-one" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:zero-or-one($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:zero-or-one" as="element()">
   <f:zero-or-one/>
 </xsl:function>
 
 <xsl:function name="f:zero-or-one" as="item()?">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="zero-or-one($arg1)"/>
 </xsl:function>

 <xsl:template match="f:one-or-more" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:one-or-more($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:one-or-more" as="element()">
   <f:one-or-more/>
 </xsl:function>
 
 <xsl:function name="f:one-or-more" as="item()+">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="one-or-more($arg1)"/>
 </xsl:function>

 <xsl:template match="f:exactly-one" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:exactly-one($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:exactly-one" as="element()">
   <f:exactly-one/>
 </xsl:function>
 
 <xsl:function name="f:exactly-one" as="item()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="exactly-one($arg1)"/>
 </xsl:function>

<!--
       Functions on sequences:                                                 
                         deep-equal()                                          
-->

 <xsl:template match="f:deep-equal" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="f:deep-equal($arg1,$arg2)"/>
 </xsl:template>
 
 <xsl:function name="f:deep-equal" as="element()">
   <f:deep-equal/>
 </xsl:function>
 
 <xsl:function name="f:deep-equal" as="node()">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:curry(f:deep-equal(),2,$arg1)"/>
 </xsl:function>
 
 <xsl:function name="f:deep-equal" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:param name="arg2" as="item()*"/>
   
   <xsl:sequence select="deep-equal($arg1,$arg2)"/>
 </xsl:function>
    
<!--
       Aggregate functions:                                                    
                     count(), avg(),                                           
                     x-max(), x-min(), x-sum()                                 
-->

 <xsl:template match="f:count" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="f:count($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:count" as="element()">
   <f:count/>
 </xsl:function>
 
 <xsl:function name="f:count" as="xs:integer">
   <xsl:param name="arg1" as="item()*"/>
   
   <xsl:sequence select="count($arg1)"/>
 </xsl:function>

 <xsl:template match="f:avg" mode="f:FXSL">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="f:avg($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:avg" as="element()">
   <f:avg/>
 </xsl:function>
 
 <xsl:function name="f:avg" as="xdt:anyAtomicType?">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="avg($arg1)"/>
 </xsl:function>

 <xsl:template match="f:x-max" mode="f:FXSL">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="f:x-max($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-max" as="element()">
   <f:x-max/>
 </xsl:function>
 
 <xsl:function name="f:x-max" as="xdt:anyAtomicType?">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="max($arg1)"/>
 </xsl:function>

 <xsl:template match="f:x-min" mode="f:FXSL">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="f:x-min($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-min" as="element()">
   <f:x-min/>
 </xsl:function>
 
 <xsl:function name="f:x-min" as="xdt:anyAtomicType?">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="min($arg1)"/>
 </xsl:function>

 <xsl:template match="f:x-sum" mode="f:FXSL">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="f:x-sum($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:x-sum" as="element()">
   <f:x-sum/>
 </xsl:function>
 
 <xsl:function name="f:x-sum" as="xdt:anyAtomicType">
   <xsl:param name="arg1" as="xdt:anyAtomicType*"/>
   
   <xsl:sequence select="sum($arg1)"/>
 </xsl:function>

 <xsl:function name="f:data" as="element()">
   <f:data/>
 </xsl:function>
 
 <xsl:function name="f:data" as="xdt:anyAtomicType*">
   <xsl:param name="seq" as="item()*"/>
   <xsl:sequence select="data($seq)"/>
 </xsl:function>
 
 <xsl:template match="f:data" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>
   <xsl:sequence select="f:data($arg1)"/>
 </xsl:template>
 
 <xsl:function name="f:xsltSort" as="item()*">
   <xsl:param name="pSeq" as="item()*"/>
   <xsl:param name="pCriteria" as="node()*"/>
   
   <xsl:perform-sort select="$pSeq">
     <xsl:sort select="f:compose-flist($pCriteria, .)"/>
   </xsl:perform-sort>
 </xsl:function> 
 
 <xsl:function name="f:attributes" as="node()*">
   <xsl:param name="pElement" as="element()+"/>
   
   <xsl:sequence select="$pElement/@*"/>
 </xsl:function>
 
 <xsl:function name="f:attributes" as="element()">
   <f:attributes/>
 </xsl:function>
 
 <xsl:template match="f:attributes" mode="f:FXSL">
   <xsl:param name="arg1" as="element()+"/>
   
   <xsl:sequence select="f:attributes($arg1)"/>
 </xsl:template>
     
 <xsl:function name="f:attribute" as="node()*">
   <xsl:param name="pElement" as="element()+"/>
   <xsl:param name="pName" as="xs:string"/>
   
   <xsl:sequence select="$pElement/@*[name()=$pName]"/>
 </xsl:function>
 
 <xsl:function name="f:attribute" as="element()">
   <f:attribute/>
 </xsl:function>
 
 <xsl:template match="f:attribute" mode="f:FXSL">
   <xsl:param name="arg1" as="element()+"/>
   <xsl:param name="arg2" as="xs:string"/>
   
   <xsl:sequence select="f:attribute($arg1,$arg2)"/>
 </xsl:template>
     
</xsl:stylesheet>