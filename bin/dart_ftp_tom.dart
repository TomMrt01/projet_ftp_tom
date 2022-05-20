import 'dart:io';
//import 'user.dart';

void main(List<String> arguments) async {
  //Installation pure-ftp
  String install = 'sudo apt install pure-ftpd -y';
  ProcessResult createi = await Process.run('bash', ['-c', install]);
  print(createi.stdout);
  print(createi.stderr);

  bool valide = false;
  //Creation de l'utilisateur
  while (valide == false) {
    print("Saisissez votre nom d'utilisateur : ");
    String? user = stdin.readLineSync().toString();
    String createuser = 'sudo useradd $user';
    ProcessResult createu = await Process.run('bash', ['-c', createuser]);
    print(createu.stdout);
    //print(createu.stderr);

    if (createu.stderr == "") {
      print('l\'utilisateur "$user" est créé');
      valide = true;
    } else {
      print("l'Utilisateur \"$user\" est deja existant");
      print("");
    }
  }
  valide = false;
  //Creation du groupe
  while (valide == false) {
    print("Saisissez votre nom de groupe : ");
    String? group = stdin.readLineSync().toString();
    String creategroup = 'sudo groupadd $group';
    ProcessResult createg = await Process.run('bash', ['-c', creategroup]);
    print(createg.stdout);
    //print(createg.stderr);

    if (createg.stderr == "") {
      print('le groupe "$group" est créé');
      valide = true;
    } else {
      print("Nom de groupe \"$group\" déja existant");
      print("");
    }
  }

  valide = false;
  //Dossier
  while (valide == false) {
    print(
        "Saissisez le nom de dossier dans lequel les utilisateurs virtuels seront stockés : ");
    String? folder = stdin.readLineSync().toString();
    String createfolder = 'sudo mkdir /home/$folder';
    ProcessResult createf = await Process.run('bash', ['-c', createfolder]);
    print(createf.stdout);
    //print(createf.stderr);

    if (createf.stderr == "") {
      print(
          "Le dossier \"$folder\" est maintenant créé dans votre /home/$folder");
      valide = true;
    } else {
      print("le dossier \"$folder\" est deja existant");
      print("");
    }
  }

  valide = false;

//Wrapper et lien symbolique
  String droit = 'sudo chmod 777 /etc/pure-ftpd/conf';
  ProcessResult created = await Process.run('bash', ['-c', droit]);
  print(created.stdout);
  print(created.stderr);

  String cat = 'cat /etc/pure-ftpd/conf/CreateHomeDir ';
  ProcessResult createcat = await Process.run('bash', ['-c', cat]);
  print(created.stdout);
  print(createcat.stderr);

  if (cat == "") {
    String confCHD = 'sudo echo "Yes" >> /etc/pure-ftpd/conf/CreateHomeDir';
    ProcessResult createc = await Process.run('bash', ['-c', confCHD]);
    print(createc.stdout);
    print(createc.stderr);
  }
}
