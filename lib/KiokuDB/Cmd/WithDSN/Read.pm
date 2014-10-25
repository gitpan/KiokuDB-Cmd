#!/usr/bin/perl

package KiokuDB::Cmd::WithDSN::Read;
use Moose::Role;

use Carp qw(croak);

use namespace::clean -except => 'meta';

with qw(
    KiokuDB::Cmd::WithDSN
);

requires "v";

sub _build_backend {
    my $self = shift;

    my $dsn = $self->dsn || croak("--dsn is required");

    $self->v("Connecting to DSN $dsn...");

    require KiokuDB::Util;
    my $b = KiokuDB::Util::dsn_to_backend( $dsn, readonly => 1 );

    $self->v(" $b\n");

    $b;
}

__PACKAGE__

__END__

=pod

=head1 NAME

KiokuDB::Cmd::WithDSN::Read - Readonly access to a DSN

=head1 SYNOPSIS

    package KiokuDB::Cmd::Command::Blort;
    use Moose;

    extends qw(KiokuDB::Cmd::Base);

    with qw(KiokuDB::Cmd::WithDSN::Read);

    augment run => sub {
        my $self = shift;

        $self->backend;
    };

=head1 DESCRIPTION

This role provides readonly access to a database.

=head1 ATTRIBUTES

=over 4

=item dsn

Command line attr.

=item backend

Contains the composed connection.

=back
