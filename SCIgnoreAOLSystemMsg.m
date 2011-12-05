/* Copyright (c) 2010-2011, Stephen Checkoway
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * • Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * • Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the
 *   distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Cocoa/Cocoa.h>
#import <Adium/AISharedAdium.h>
#import <Adium/AIContentObject.h>
#import <Adium/AIPlugin.h>
#import <Adium/AIContentControllerProtocol.h>


@interface SCIgnoreAOLSystemMsg : AIPlugin <AIContentFilter>
@end



@implementation SCIgnoreAOLSystemMsg

- (void)installPlugin
{
	[[adium contentController] registerContentFilter:self
						  ofType:AIFilterContent
					       direction:AIFilterIncoming];
}

- (void)uninstallPlugin
{
	[[adium contentController] unregisterContentFilter:self];
}

- (NSAttributedString *)filterAttributedString:(NSAttributedString *)str context:(id)context
{
	if( ![context isKindOfClass:[AIContentObject class]] )
		return str;
	id src = [(AIContentObject *)context source];
	if( ![src isKindOfClass:[AIListContact class]] )
		return str;
	if( [[src ownDisplayName] isEqualToString:@"aolsystemmsg"] )
		return nil;
	return str;
}

- (float)filterPriority
{
	return (float)DEFAULT_FILTER_PRIORITY;
}

@end
