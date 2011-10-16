<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ Copyright (c) 2011 Alexander Dovzhikov <alexander.dovzhikov@gmail.com>.
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
  ~ cv-text.xsl
  ~
  ~ Created on 15.10.2011 23:31:11
  -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8" media-type="text/plain" indent="no"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="firstName" select="document/personal/first-name"/>
    <xsl:variable name="lastName" select="document/personal/last-name"/>
    <xsl:variable name="applicantName" select="concat($firstName, ' ', $lastName)"/>
    <xsl:variable name="apos">'</xsl:variable>
    <xsl:template match="/">
        <!--<xsl:apply-templates select="document/personal"/>-->
        <!--<xsl:apply-templates select="document/education"/>-->
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="personal">
        <xsl:call-template name="section">
            <xsl:with-param name="section-name">PERSONAL INFORMATION</xsl:with-param>
        </xsl:call-template>
        <xsl:text>Applicant name:  </xsl:text>
        <xsl:value-of select="$applicantName"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Date of birth:   </xsl:text>
        <xsl:value-of select="birthday"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Marital status:  </xsl:text>
        <xsl:value-of select="marital-status"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Languages:       </xsl:text>
        <xsl:for-each select="languages/language">
            <xsl:value-of select="."/> (<xsl:value-of select="@type"/>)
            <xsl:if test="position() &lt; last()">,</xsl:if>
        </xsl:for-each>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Phone:           </xsl:text>
        <xsl:value-of select="phone[@type='home']"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Cell:            </xsl:text>
        <xsl:value-of select="phone[@type='mobile']"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Email:           </xsl:text>
        <xsl:value-of select="email"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:apply-templates select="address"/>
        <xsl:text>&#xD;&#xA;&#xD;&#xA;</xsl:text>
    </xsl:template>
    <xsl:template match="address">
        <xsl:text>Address:         </xsl:text>
        <xsl:value-of select="street"/>
        <xsl:text>&#xD;&#xA;                 </xsl:text>
        <xsl:value-of select="city"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="country"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
    </xsl:template>
    <xsl:template match="education">
        <xsl:call-template name="section">
            <xsl:with-param name="section-name">EDUCATION</xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates select="university"/>
    </xsl:template>
    <xsl:template match="university">
        <xsl:value-of select="start-date"/>-<xsl:value-of select="end-date"/>,
        <xsl:value-of select="university-name"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Department:        </xsl:text>
        <xsl:value-of select="department"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Specialty/Course:  </xsl:text>
        <xsl:value-of select="specialty"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Gained Level:      </xsl:text>
        <xsl:value-of select="level"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:text>Diploma Thesis:    </xsl:text>
        <xsl:value-of select="diploma"/>
        <xsl:text>&#xD;&#xA;&#xD;&#xA;&#xD;&#xA;</xsl:text>
    </xsl:template>
    <xsl:template match="objective">
        <xsl:call-template name="section">
            <xsl:with-param name="section-name">OBJECTIVE</xsl:with-param>
        </xsl:call-template>
        <xsl:value-of select="."/>
        <xsl:text>&#xD;&#xA;&#xD;&#xA;&#xD;&#xA;</xsl:text>
    </xsl:template>
    <!-- Summary -->
    <xsl:template match="summary">
        <xsl:call-template name="section">
            <xsl:with-param name="section-name">PROFESSIONAL SUMMARY</xsl:with-param>
        </xsl:call-template>
        <xsl:for-each select="summary-item">
            <xsl:call-template name="wrap-string">
                <xsl:with-param name="str">
                    <xsl:text>- </xsl:text>
                    <xsl:value-of select="normalize-space(.)"/>
                    <xsl:text>.</xsl:text>
                </xsl:with-param>
                <xsl:with-param name="wrap-col">80</xsl:with-param>
                <xsl:with-param name="break-mark">
                    <xsl:text>&#xD;&#xA;</xsl:text>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:text>&#xD;&#xA;</xsl:text>
        </xsl:for-each>
        <xsl:text>&#xD;&#xA;&#xD;&#xA;</xsl:text>
    </xsl:template>
    <!-- Skills -->
    <xsl:template match="skills">
        <xsl:call-template name="section">
            <xsl:with-param name="section-name">SKILLS</xsl:with-param>
        </xsl:call-template>
        <xsl:for-each select="skill-set">
            <xsl:call-template name="text-field">
                <xsl:with-param name="str" select="concat(skill-set-name, ':')"/>
                <xsl:with-param name="width" select="25"/>
            </xsl:call-template>
            <xsl:call-template name="wrap-string">
                <xsl:with-param name="str"><xsl:for-each select="skill"><xsl:value-of select="."/><xsl:if test="position() &lt; last()">, </xsl:if></xsl:for-each>.<xsl:text>&#xD;&#xA;</xsl:text></xsl:with-param>
                <xsl:with-param name="wrap-col">55</xsl:with-param>
                <xsl:with-param name="break-mark">
                    <xsl:text>&#xD;&#xA;</xsl:text>
                    <xsl:call-template name="append-pad">
                        <xsl:with-param name="length">25</xsl:with-param>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
        <xsl:text>&#xD;&#xA;&#xD;&#xA;</xsl:text>
    </xsl:template>
    <!-- auxiliary templates -->
    <xsl:template name="section">
        <xsl:param name="section-name"/>
        <xsl:value-of select="$section-name"/>
        <xsl:text>&#xD;&#xA;&#xD;&#xA;</xsl:text>
    </xsl:template>
    <xsl:template name="wrap-string">
        <xsl:param name="str"/>
        <xsl:param name="wrap-col"/>
        <xsl:param name="break-mark"/>
        <xsl:param name="pos" select="0"/>
        <xsl:choose>
            <xsl:when test="contains( $str, ' ' )">
                <xsl:variable name="first-word" select="substring-before( $str, ' ' )"/>
                <xsl:variable name="pos-now" select="$pos + 1 + string-length( $first-word )"/>
                <xsl:choose>
                    <xsl:when test="$pos > 0 and $pos-now >= $wrap-col">
                        <xsl:copy-of select="$break-mark"/>
                        <xsl:call-template name="wrap-string">
                            <xsl:with-param name="str" select="$str"/>
                            <xsl:with-param name="wrap-col" select="$wrap-col"/>
                            <xsl:with-param name="break-mark" select="$break-mark"/>
                            <xsl:with-param name="pos" select="0"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$first-word"/>
                        <xsl:text> </xsl:text>
                        <xsl:call-template name="wrap-string">
                            <xsl:with-param name="str" select="substring-after( $str, ' ' )"/>
                            <xsl:with-param name="wrap-col" select="$wrap-col"/>
                            <xsl:with-param name="break-mark" select="$break-mark"/>
                            <xsl:with-param name="pos" select="$pos-now"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$pos + string-length( $str ) >= $wrap-col">
                    <xsl:value-of select="$break-mark"/>
                </xsl:if>
                <xsl:value-of select="$str"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="text-field">
        <xsl:param name="str"/>
        <xsl:param name="width"/>
        <xsl:variable name="remainder" select="$width - string-length($str)"/>
        <xsl:copy-of select="$str"/>
        <xsl:call-template name="append-pad">
            <xsl:with-param name="length" select="$remainder"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="append-pad">
        <xsl:param name="length"/>
        <xsl:if test="$length > 0">
            <xsl:text> </xsl:text>
            <xsl:call-template name="append-pad">
                <xsl:with-param name="length" select="$length - 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>