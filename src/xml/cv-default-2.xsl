<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (c) 2012 Alexander Dovzhikov <alexander.dovzhikov@gmail.com>.
  ~ All rights reserved.
  ~
  ~ Redistribution and use in source and binary forms, with or without modification, are
  ~ permitted provided that the following conditions are met:
  ~
  ~    1. Redistributions of source code must retain the above copyright notice, this list of
  ~       conditions and the following disclaimer.
  ~
  ~    2. Redistributions in binary form must reproduce the above copyright notice, this list
  ~       of conditions and the following disclaimer in the documentation and/or other materials
  ~       provided with the distribution.
  ~
  ~ THIS SOFTWARE IS PROVIDED BY ALEXANDER DOVZHIKOV ''AS IS'' AND ANY EXPRESS OR IMPLIED
  ~ WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  ~ FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL dan OR
  ~ CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  ~ CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  ~ SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
  ~ ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  ~ NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  ~ ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ~
  ~ cv-default-2.xsl
  ~
  ~ Created on 26.02.2012 01:07:22
  -->
<!-- noinspection CheckNodeTest -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="firstName" select="document/personal/first-name"/>
    <xsl:variable name="lastName" select="document/personal/last-name"/>
    <xsl:variable name="applicantName" select="concat($firstName, ' ', $lastName)"/>
    <xsl:variable name="apos">'</xsl:variable>
    <xsl:template match="/">
        <fo:root font-family="Verdana" font-size="10pt">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-portrait"
                                       page-height="29.7cm"
                                       page-width="21.0cm"
                                       margin-top="1cm"
                                       margin-bottom="1cm"
                                       margin-left="3cm"
                                       margin-right="3cm">
                    <fo:region-body margin-top="2cm" margin-bottom="1cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after extent="0.8cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:declarations>
                <x:xmpmeta xmlns:x="adobe:ns:meta/">
                    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
                        <rdf:Description rdf:about=""
                                         xmlns:dc="http://purl.org/dc/elements/1.1/">
                            <!-- Dublin Core properties go here -->
                            <dc:title><xsl:value-of select="concat($applicantName, $apos, 's CV')"/></dc:title>
                            <dc:creator><xsl:value-of select="$applicantName"/></dc:creator>
                            <dc:description><xsl:value-of select="concat($applicantName, $apos, 's CV')"/></dc:description>
                        </rdf:Description>
                        <rdf:Description rdf:about=""
                                         xmlns:xmp="http://ns.adobe.com/xap/1.0/">
                            <!-- XMP properties go here -->
                            <xmp:CreatorTool>Apache FOP</xmp:CreatorTool>
                          </rdf:Description>
                        <rdf:Description rdf:about=""
                                         xmlns:pdf="http://ns.adobe.com/pdf/1.3/">
                            <!-- PDF properties go here -->
                            <pdf:Keywords>Java,Senior,Developer,Dovzhikov,Alexander</pdf:Keywords>
                        </rdf:Description>
                    </rdf:RDF>
                </x:xmpmeta>
            </fo:declarations>
            <!-- Insert Bookmark tree here -->
            <fo:page-sequence master-reference="A4-portrait">
                <!-- footer -->
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block font-size="8pt"
                              border-top-style="solid"
                              border-top-width="thin"
                              padding-top="0.2cm">
                        Generated with Apache FOP
                    </fo:block>
                </fo:static-content>
                <!-- main body -->
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <xsl:template match="personal">
        <fo:block font-size="16pt"
                  font-weight="bold"
                  margin-bottom="10pt"
                  text-align="center"
                  text-transform="uppercase">
            <xsl:value-of select="$applicantName"/>
        </fo:block>
        <fo:table table-layout="fixed" width="100%">
            <fo:table-column text-align="left" column-width="70%"/>
            <fo:table-column text-align="end"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:text>Mobile: </xsl:text>
                            <xsl:value-of select="phone[@type='mobile']"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block text-align="right">
                            <xsl:value-of select="address/street"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:text>Email: </xsl:text>
                            <fo:basic-link color="blue">
                                <xsl:attribute name="text-decoration">
                                    <xsl:text>underline</xsl:text>
                                </xsl:attribute>
                                <xsl:attribute name="external-destination">
                                    <xsl:value-of select="concat('mailto:', email)"/>
                                </xsl:attribute>
                                <xsl:value-of select="email"/>
                            </fo:basic-link>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block text-align="right">
                            <xsl:value-of select="address/city"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="address/country"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:text>Visa: </xsl:text>
                            <xsl:value-of select="visa-type"/>
                            <xsl:text>.</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:text>Languages: </xsl:text>
                            <xsl:for-each select="languages/language">
                                <xsl:value-of select="."/>
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="@type"/>
                                <xsl:text>)</xsl:text>
                                <xsl:if test="position() &lt; last()">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:for-each>
                            <xsl:text>.</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
</xsl:stylesheet>