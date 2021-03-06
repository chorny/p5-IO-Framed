
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile1(
    META_MERGE => {
        resources => {
            repository => {
                type => 'git',
                url => 'git://github.com/FGasper/p5-IO-Framed.git',
                web => 'https://github.com/FGasper/p5-IO-Framed',
            },
        },
    },

    NAME         => 'IO::Framed',
    VERSION_FROM => 'lib/IO/Framed.pm',         # finds \$VERSION
    AUTHOR       => 'Felipe Gasper',
    ABSTRACT_FROM => 'lib/IO/Framed.pm',
    LICENSE      => 'perl',

    PREREQ_PM    => {
        'autodie'                  => 0,
        'parent'                   => 0,
        'X::Tiny'   => 0,
        'IO::SigGuard' => 0,
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources   => {
            repository => {
                type => 'git',
                url  => 'https://github.com/FGasper/p5-IO-Framed.git',
                web  => 'https://github.com/FGasper/p5-IO-Framed',
            },
        },
    },
    TEST_REQUIRES => {
        'Test::More'      => 0,
        'Test::Simple'    => 0,
        ( $^O eq 'MSWin32' ? ('Win32::Socketpair' => 0.02) : () ),
    },
);

sub WriteMakefile1 {  #Compatibility code for old versions of EU::MM. Written by Alexandr Ciornii, version 2. Added by eumm-upgrade.
    my %params=@_;
    my $eumm_version=$ExtUtils::MakeMaker::VERSION;
    $eumm_version=eval $eumm_version;
    die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
    die "License not specified" if not exists $params{LICENSE};
    if ($params{AUTHOR} and ref($params{AUTHOR}) eq 'ARRAY' and $eumm_version < 6.5705) {
        $params{META_ADD}->{author}=$params{AUTHOR};
        $params{AUTHOR}=join(', ',@{$params{AUTHOR}});
    }
    if ($params{TEST_REQUIRES} and $eumm_version < 6.64) {
        $params{BUILD_REQUIRES}={ %{$params{BUILD_REQUIRES} || {}} , %{$params{TEST_REQUIRES}} };
        delete $params{TEST_REQUIRES};
    }
    if ($params{BUILD_REQUIRES} and $eumm_version < 6.5503) {
        #EUMM 6.5502 has problems with BUILD_REQUIRES
        $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
        delete $params{BUILD_REQUIRES};
    }
    delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
    delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
    delete $params{META_MERGE} if $eumm_version < 6.46;
    delete $params{META_ADD} if $eumm_version < 6.46;
    delete $params{LICENSE} if $eumm_version < 6.31;

    WriteMakefile(%params);
}
