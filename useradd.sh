#!/bin/bash
   
### �C�ӂ̃O���[�vID��ݒ�B(�ϒl�ł�)
GROUP_ID="1000"
 
### �o�^���������[�U��echo�œn��
echo -e "batchuser\nwebdev" |while read USERNAME;do
 
  ### /etc/passwd�t�@�C�����烆�[�UID���擾
  USER_ID=`awk -F ':' '$4=="'${GROUP_ID}'"{ID=$3}END{print ID+1}' /etc/passwd` 
 
  ### �p�X���[�h�𐶐��B( "���[�U��_pass" �Ƃ���������ɂȂ�)
  PASSWORD=`perl -e "print(crypt('${USERNAME}_pass', 'a5'));"`
 
  ### ���ɓo�^����ĂȂ����̃`�F�b�N
  grep "${USERNAME}" /etc/passwd > /dev/null 2>&1 
 
  ### �o�^����Ă��Ȃ��ꍇ�Agrep�̖߂�l��1�ɂȂ�
  if [ "$?" == "1" ];then
 
    ### useradd�����s
    useradd -u ${USER_ID} -g ${GROUP_ID} -d /home/${USERNAME} -m -p ${PASSWORD} ${USERNAME} 
  fi
done

