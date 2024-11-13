"""
Fixes race condition with db
"""
import time

from psycopg2 import OperationalError as Psycopg2OpError

from django.db.utils import OperationalError
from django.core.management.base import BaseCommand

from typing import Any

class Command(BaseCommand):
    def handle(self, *args: Any, **options: Any):
        self.stdout.write('Waiting for database...')
        db_up: bool = False
        while db_up is False:
            try:
                self.check(databases=['default'])
                db_up: bool = True
            except (Psycopg2OpError, OperationalError):
                self.stdout.write('Database unavailable, waiting 1 second...')
                time.sleep(1)

        self.stdout.write(self.style.SUCCESS('Database available!'))
