use strict;
use warnings;

package RT::Extension::OrganizationalCustomFieldValues;

use base qw(RT::CustomFieldValues::External);

our $VERSION = '0.0.1';

=head1 NAME

RT-Extension-OrganizationalCustomFieldValues - Using organization of users to fill customfields

=head1 DESCRIPTION

[Why would someone install this extension? What does it do? What problem
does it solve?]

=head1 RT VERSION

Works with RT >= 4.2.0

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item Edit your F</opt/rt4/etc/RT_SiteConfig.pm>

Add this lines:

    Plugin('RT::Extension::OrganizationalCustomFieldValues');
    Set(@CustomFieldValuesSources, 'RT::Extension::OrganizationalCustomFieldValues');

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=back

=head1 AUTHOR

NETWAYS GmbH <support@netways.de>

=head1 BUGS

All bugs should be reported on
L<GitHub|https://github.com/NETWAYS/rt-extension-organizationalcustomfieldvalues>.

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2018 by NETWAYS GmbH
This is free software, licensed under:
  The GNU General Public License, Version 2, June 1991

=cut

sub SourceDescription {
    return 'Organization from user records';
}

sub ExternalValues {
    my $self  = shift;
    my $field = 'Organization';
    my $out   = [];
    my $users = RT::Users->new(RT->SystemUser);

    $users->LimitToEnabled();
    $users->Limit(
        FIELD    => $field,
        OPERATOR => '<>',
        VALUE    => ''
    );

    $users->Columns($field);

    $users->GroupByCols({
        FIELD    => $field
    });

    $users->OrderBy(
        FIELD => $field
    );

    while (my $user = $users->Next()) {
        push @{ $out }, {
            name => $user->$field
        };
    }

    # each element of the array is a reference to hash that describe a value
    # possible keys are name, description, sortorder, and category
    return $out;
}

1;
