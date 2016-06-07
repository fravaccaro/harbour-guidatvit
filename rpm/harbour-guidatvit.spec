# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-guidatvit

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:        Guida TV Italia
Version:        0.1.4
Release:        1
Group:          Qt/Qt
License:        BSD
Packager:       fravaccaro <fravaccaro@jollacommunity.it>
URL:            www.jollacommunity.it
Source0:        %{name}-%{version}.tar.bz2
BuildArch:      noarch
Requires:       sailfishsilica-qt5 >= 0.10.9
Requires:       libsailfishapp-launcher
BuildRequires:  desktop-file-utils

%description
TV Guide for the main Italian TV channels. Powered by TV Zam and teleguida.tv.


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qtc_qmake5 SPECVERSION=%{version}

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(644,root,root,755)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/86x86/apps/%{name}.png
%{_datadir}/icons/hicolor/108x108/apps/%{name}.png
%{_datadir}/icons/hicolor/128x128/apps/%{name}.png
%{_datadir}/icons/hicolor/256x256/apps/%{name}.png
# >> files
# << files


%changelog
* Tue Jun 7 2016 0.1.4
- Fixed webview high-power consumption.

* Sun Jun 5 2016 0.1.3
- Database fix.

* Thu Jun 2 2016 0.1.1
- UI fixes.

* Thu Jun 2 2016 0.1.0
- First public release.
