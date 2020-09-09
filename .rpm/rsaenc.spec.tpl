Name:           rsaenc
Version:        __VERSION__
Release:        1%{?dist}
Summary:        A reinvented RSA Encryption/Decryption tool

License:        MIT
URL:            https://reinvented-stuff.com/rsaenc
Source0:        __SOURCE_TARGZ_FILENAME__


%description
rsaenc helps encrypt and decrypt short messages
using your ssh-rsa keypair.

%prep
%setup -q


%build
make %{?_smp_mflags} build


%install
rm -rf $RPM_BUILD_ROOT
%make_install


%files
%attr(755, root, root) /usr/bin/rsaenc
%attr(644, root, root) /usr/share/doc/rsaenc-__VERSION__/README.md
%doc



%changelog
