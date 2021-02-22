#!/bin/bash

NO_ARGS=0
E_OPTERR=65

if [ $# -eq "$NO_ARGS" ]
then
  printf "Отсутствуют аргументы. Должен быть хотя бы один аргумент.\n"
  printf "Использование: $0 {migrate|-migrate|clean|-clean|info|-info|repair|-repair}\n"
  printf " $0 migrate|-migrate - run migrations\n" 
  printf " $0 clean|-clean - clean migrations\n"
  printf " $0 info|-info - information about migrations"
  printf " $0 repair|-repair - repair migrations\n"
  exit $E_OPTERR
fi

while :; do
	case "$1" in
	migrate|-migrate)
	  ./flyway migrate
	 ;;
	clean|-clean)
	  ./flyway clean
	 ;;
	info|-info)
	  ./flyway info
	 ;;
	repair|-repair)
	  ./flyway repair
	 ;;
	--)
	  shift
	 ;;
	?* | -?*)
	  printf 'ПРЕДУПРЕЖДЕНИЕ: Неизвестный аргумент (проигнорировано): %s\n' "$1" >&2
	 ;;
	*)
	  break
	esac
	shift
done

exit 0
